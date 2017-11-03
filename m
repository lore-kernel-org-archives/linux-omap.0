From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: SDP4430 nightly regression (was: Re: [GIT PULL] two omap regression
 fixes)
Date: Fri, 3 Nov 2017 10:43:16 +0000
Message-ID: <20171103104316.GE28231@n2100.armlinux.org.uk>
References: <pull-1509652473-291160@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1509652473-291160@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 02, 2017 at 12:55:33PM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 4afa616ce937f88d9a69a71b8c561551596a81e3:
> 
>   ARM: dts: am43xx-epos-evm: Remove extra CPSW EMAC entry (2017-09-19 10:59:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-rc7-signed
> 
> for you to fetch changes up to 6301d58477bc11116c78c9542871f27ae374278d:
> 
>   ARM: OMAP2/3: CM: fix cm_split_idlest functionality (2017-10-30 09:14:55 -0700)
> 
> ----------------------------------------------------------------
> Two regression fixes for omap3 to fix mmc3 issues noticed on nokia n9.
> 
> These have been broken for a few months and we don't have the LCD yet
> functional on n9. So these can wait for the merge window if considered
> too late for the -rc cycle at this point.
> 
> ----------------------------------------------------------------
> Tero Kristo (2):
>       ARM: OMAP3: hwmod_data: add missing module_offs for MMC3
>       ARM: OMAP2/3: CM: fix cm_split_idlest functionality
> 
>  arch/arm/mach-omap2/cm_common.c            | 6 +++++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 1 +
>  arch/arm/mach-omap2/prcm-common.h          | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)

I don't know if this is covered in your pull request, but since 31st
October, the SDP4430 no longer recovers from a hibernation attempt.
(as found by my nightly tests).

4.14-rc6+ plus my tree plus arm-soc/for-next branch worked fine:

root@omap-4430sdp:~# if [ -f /sys/power/disk ]; then echo reboot > /sys/power/disk; echo disk > /sys/power/state; fi
PM: hibernation entry
PM: Syncing filesystems ...
PM: done.
Freezing user space processes ... (elapsed 0.022 seconds) done.
OOM killer disabled.
PM: Basic memory bitmaps created
PM: Preallocating image memory... done (allocated 13293 pages)
PM: Allocated 53172 kbytes in 0.17 seconds (312.77 MB/s)
Freezing remaining freezable tasks ... (elapsed 0.016 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
omap_hwmod: gpio2: _wait_target_disable failed
Disabling non-boot CPUs ...
PM: Creating hibernation image:
PM: Need to copy 13028 pages
PM: Normal pages needed: 9836 + 1024, available pages: 53639
PM: Hibernation image created (13028 pages copied)
Enabling non-boot CPUs ...
CPU1 is up
PM: Cannot find swap device, try swapon -a.
PM: Cannot get swap writer
PM: Basic memory bitmaps freed
OOM killer enabled.
Restarting tasks ... done.
PM: hibernation exit
root@omap-4430sdp:~#

The above is an example of success - it's intentional that there's no
swap, which prevents the system entering hibernation.  The purpose of
this test is to exercise the PM and CPU hotplug paths.

4.14-rc7+ plus my tree plus arm-soc/for-next now fails:

root@omap-4430sdp:~# if [ -f /sys/power/disk ]; then echo reboot > /sys/power/disk; echo disk > /sys/power/state; fi
PM: hibernation entry
PM: Syncing filesystems ...
PM: done.
Freezing user space processes ... (elapsed 0.022 seconds) done.
OOM killer disabled.
PM: Basic memory bitmaps created
PM: Preallocating image memory... done (allocated 13200 pages)
PM: Allocated 52800 kbytes in 0.17 seconds (310.58 MB/s)
Freezing remaining freezable tasks ... (elapsed 0.015 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

>From what I can see, there's no change in arm-soc/for-next across that
period - the same SHA1 hash was merged for the build tree update
on the 27th October as was used on the 30th October.

There's no change (apart from the SHA hashes, the diff between them is
empty) in the branch I merged between those two dates either for my
tree.  The SHA hash change was due to squashing some MPS3 changes to
fix a build error for the recently added mps3 build target in the
builder.

The material difference is Linus' tip, which changed from f34157878d3b
("Merge tag 'nfs-for-4.14-4' of git://git.linux-nfs.org/projects/trondmy/linux-nfs")
to 0b07194bb55e ("Linux 4.14-rc7").

In the diffstat between the two build trees (post merge), I don't see
anything in arch/arm that could account for it.  I do see some power
changes:

 drivers/base/power/domain_governor.c               |  53 +--
 drivers/base/power/qos.c                           |   2 +-
 drivers/base/power/runtime.c                       |   2 +-
 drivers/base/power/sysfs.c                         |  25 +-

but nothing in tty or serial.  These power changes look like QoS
changes, which probably aren't related.

Just to make sure, I've diffed the build tree SHAs and the change in
Linus' tip, and the two diffs match apart from a couple of SHA blob
hashes on a couple of files (EFI stub and MAINTAINERS).

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
