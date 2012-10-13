From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans.rullgard@linaro.org>
Subject: Re: [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3
 and CONFIG_VFPv3 set
Date: Sat, 13 Oct 2012 11:50:45 +0100
Message-ID: <yw1xr4p2myre.fsf@unicorn.mansr.com>
References: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com>
 <20121013090255.GT28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121013090255.GT28061@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 13 Oct 2012 10:02:55 +0100")
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
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Oct 13, 2012 at 04:46:18AM +0000, Paul Walmsley wrote:
>> =

>> After commit 846a136881b8f73c1f74250bf6acfaa309cab1f2 ("ARM: vfp: fix
>> saving d16-d31 vfp registers on v6+ kernels"), the OMAP 2430SDP board
>> started crashing during boot with omap2plus_defconfig:
>> =

>> [    3.875122] mmcblk0: mmc0:e624 SD04G 3.69 GiB
>> [    3.915954]  mmcblk0: p1
>> [    4.086639] Internal error: Oops - undefined instruction: 0 [#1] SMP =
ARM
>> [    4.093719] Modules linked in:
>> [    4.096954] CPU: 0    Not tainted  (3.6.0-02232-g759e00b #570)
>> [    4.103149] PC is at vfp_reload_hw+0x1c/0x44
>> [    4.107666] LR is at __und_usr_fault_32+0x0/0x8
>> =

>> It turns out that the context save/restore fix unmasked a latent bug in =

>> commit 5aaf254409f8d58229107b59507a8235b715a960 ("ARM: 6203/1: Make VFPv=
3 =

>> usable on ARMv6").  When CONFIG_VFPv3 is set, but the kernel is booted o=
n =

>> a pre-VFPv3 core, the code attempts to save and restore the d16-d31 VFP =

>> registers.  These are only present on non-D16 VFPv3+, so the kernel dies =

>> with an undefined instruction exception.  The kernel didn't crash before =

>> commit 846a136 because the save and restore code only touched d0-d15, =

>> present on all VFP.
>> =

>> Fix to save and restore the d16-d31 registers only if they are
>> present.
>
> No.  VFPv3D16 HWCAP means that the VFP supports just 16 double registers
> - and it communicates this information to userspace.  If this bit is clea=
r,
> and the VFP only has 16 double registers, then _that_ is a bug.

That bit will be clear on VFPv2 (because it's not v3), and this has only
16 D registers.  The high D registers are present if (vfpv3 && !vfpv3d16).
Pre-calculating this to avoid doing it in the context save/restore code
is probably a good idea.

-- =

M=E5ns Rullg=E5rd
mans@mansr.com
