From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 25/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
Date: Thu, 23 Jun 2011 11:47:11 +0100
Message-ID: <20110623104711.GF9449@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
	<20110622161021.GB9449@n2100.arm.linux.org.uk>
	<4E027BD3.6030500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E027BD3.6030500@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 23, 2011 at 05:03:39AM +0530, Santosh Shilimkar wrote:
> On 6/22/2011 9:40 PM, Russell King - ARM Linux wrote:
>> A couple of things to point out here:
>>
>> On Wed, Jun 22, 2011 at 04:16:58PM +0100, Russell King - ARM Linux wrote:
>>> -	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
>>> -	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
>>> -	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
>>> -	mrs	r7, cpsr		@ Store current cpsr
>>> -	stmia	r8!, {r4-r7}
>>
>> 1. The User r/w thread and process ID is not saved/restored by Linux over
>> context switches, so it doesn't serve any useful purpose to save and
>> restore over resume.
>>
> It will be needed for CPUIDLE I guess.

No it isn't.  It is not used by Linux at all - the only thread register
which is used is the User r/o thread register, and I've patched the
proc-v7 code to preserve that register.

>> 2. Compare the instruction saving and restoring the vector base address
>> (see below for the restore code.)
>>
> That's typo. It should have been mcr. Actually VBAR isn't used on GP
> devices but might be used on secure devices. I know that common suspend
> code doesn't consider this register. It's fine to keep it that way
> and if OMAP needs it, it can save/restored outside common code.

The kernel doesn't use or initialize the register, so its not something
which the kernel should be concerned about.  Presumably secure devices
need to restore the secure-mode version of that register.

However, there's an extra twist here:
| On an implementation that does not include the Security Extensions all
| CP15 c12 encodings are UNDEFINED.

And a further twist is this:
| B3.12.40 c12, Vector Base Address Register (VBAR)
| When the Security Extensions are implemented and high exception vectors are
| not selected, the Vector Base Address Register, VBAR, provides the exception
| base address for exceptions that are not handled in Monitor mode, see
| Exception vectors and the exception base address on page B1-30. The high
| exception vectors always have the base address 0xFFFF0000 and are not
| affected by the value of VBAR.

Since we always select high exception vectors, VBAR is not used, so we have
no requirement to save and restore this register on any ARMv7 MMU platform.
Given that it would be dangerous to do so (due to not knowing whether
security stuff is implemented or not) ignoring the presence of this register
is for the best.
