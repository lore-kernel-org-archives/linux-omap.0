From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Tue, 21 Jun 2011 17:06:58 -0700
Message-ID: <4E013222.6080208@codeaurora.org>
References: <20110620114019.GH2082@n2100.arm.linux.org.uk>
	<20110620142338.GL2082@n2100.arm.linux.org.uk>
	<4DFF5F29.2000904@ti.com> <4E005F92.8030208@ti.com>
	<20110621100057.GB23802@n2100.arm.linux.org.uk>
	<4E006FA0.7050508@ti.com>
	<20110621101900.GC23802@n2100.arm.linux.org.uk>
	<4E00708C.6050108@ti.com>
	<20110621102600.GD23802@n2100.arm.linux.org.uk>
	<4E00FC2F.1010400@codeaurora.org>
	<20110621231035.GE23802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110621231035.GE23802@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/21/2011 04:10 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 21, 2011 at 01:16:47PM -0700, Stephen Boyd wrote:
>> On 06/21/2011 03:26 AM, Russell King - ARM Linux wrote:
>>> On Tue, Jun 21, 2011 at 03:51:00PM +0530, Santosh Shilimkar wrote:
>>>> On 6/21/2011 3:49 PM, Russell King - ARM Linux wrote:
>>>>> I won't be committing the init/calibrate.c change to a git tree - it
>>>>> isn't ARM stuff so it goes in patch form.
>>>> Patches with change log would be fine as well.
>>> The answer is not at the moment, but maybe soon.
>> Should we send those two patches to the stable trees as well? They seem
>> to fix issues with cpu onlining that have existed for a long time.
> Looks to me like the problem was introduced for 2.6.39-rc1, so we
> should probably get the fix into the 2.6.39-stable tree too.

Are we talking about the loops_per_jiffy problem or the cpu_active
problem? I would think the cpu_active problem has been there since SMP
support was added to ARM and the loops_per_jiffy problem has been there
(depending on the compiler) since 8a9e1b0 ([PATCH] Platform SMIs and
their interferance with tsc based delay calibration, 2005-06-23).

So pretty much every stable tree would want both of these patches.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
