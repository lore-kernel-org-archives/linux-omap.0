From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check
 sequence
Date: Sun, 10 Apr 2016 18:42:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604101840270.11457@utopia.booyaka.com>
References: <1459812638-38789-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459812638-38789-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Suman

On Mon, 4 Apr 2016, Suman Anna wrote:

> The omap_hwmod _enable() function can return success without setting
> the hwmod state to _HWMOD_STATE_ENABLED for IPs with reset lines when
> all of the reset lines are asserted. The omap_hwmod _idle() function
> also performs a similar check, but after checking for the hwmod state
> first. This triggers the WARN when pm_runtime_get and pm_runtime_put
> are invoked on IPs with all reset lines asserted. Reverse the checks
> for hwmod state and reset lines status to fix this.
> 
> Issue found during a unbind operation on a device with reset lines
> still asserted, example backtrace below
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 1 PID: 879 at arch/arm/mach-omap2/omap_hwmod.c:2207 _idle+0x1e4/0x240()
>  omap_hwmod: mmu_dsp: idle state can only be entered from enabled state
>  Modules linked in:
>  CPU: 1 PID: 879 Comm: sh Not tainted 4.4.0-00008-ga989d951331a #3
>  Hardware name: Generic OMAP5 (Flattened Device Tree)
>  [<c0018e60>] (unwind_backtrace) from [<c0014dc4>] (show_stack+0x10/0x14)
>  [<c0014dc4>] (show_stack) from [<c037ac28>] (dump_stack+0x90/0xc0)
>  [<c037ac28>] (dump_stack) from [<c003f420>] (warn_slowpath_common+0x78/0xb4)
>  [<c003f420>] (warn_slowpath_common) from [<c003f48c>] (warn_slowpath_fmt+0x30/0x40)
>  [<c003f48c>] (warn_slowpath_fmt) from [<c0028c20>] (_idle+0x1e4/0x240)
>  [<c0028c20>] (_idle) from [<c0029080>] (omap_hwmod_idle+0x28/0x48)
>  [<c0029080>] (omap_hwmod_idle) from [<c002a5a4>] (omap_device_idle+0x3c/0x90)
>  [<c002a5a4>] (omap_device_idle) from [<c0427a90>] (__rpm_callback+0x2c/0x60)
>  [<c0427a90>] (__rpm_callback) from [<c0427ae4>] (rpm_callback+0x20/0x80)
>  [<c0427ae4>] (rpm_callback) from [<c0427f84>] (rpm_suspend+0x138/0x74c)
>  [<c0427f84>] (rpm_suspend) from [<c0428b78>] (__pm_runtime_idle+0x78/0xa8)
>  [<c0428b78>] (__pm_runtime_idle) from [<c041f514>] (__device_release_driver+0x64/0x100)
>  [<c041f514>] (__device_release_driver) from [<c041f5d0>] (device_release_driver+0x20/0x2c)
>  [<c041f5d0>] (device_release_driver) from [<c041d85c>] (unbind_store+0x78/0xf8)
>  [<c041d85c>] (unbind_store) from [<c0206df8>] (kernfs_fop_write+0xc0/0x1c4)
>  [<c0206df8>] (kernfs_fop_write) from [<c018a120>] (__vfs_write+0x20/0xdc)
>  [<c018a120>] (__vfs_write) from [<c018a9cc>] (vfs_write+0x90/0x164)
>  [<c018a9cc>] (vfs_write) from [<c018b1f0>] (SyS_write+0x44/0x9c)
>  [<c018b1f0>] (SyS_write) from [<c0010420>] (ret_fast_syscall+0x0/0x1c)
>  ---[ end trace a4182013c75a9f50 ]---
> 
> While at this, fix the sequence in _shutdown() as well, though there
> is no easy reproducible scenario.
> 
> Fixes: 747834ab8347 ("ARM: OMAP2+: hwmod: revise hardreset behavior")
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, I'm going to queue this for v4.7, mostly to get in more testing 
and integration time.  Let me know if you think it's important enough to 
go into v4.6-rc.


> There are couple of pr_debug statements that only print once the code
> flow passes through certain conditions. Not sure if you wanted them
> to be printed first thing when entering the functions or only if the
> function is really doing something. But it is still not consistent
> between _enable(), _idle() and _shutdown().

Yeah those need to be cleaned up.  Seems like the best thing to do 
is to move them all to the beginning of their respective functions.


- Paul
