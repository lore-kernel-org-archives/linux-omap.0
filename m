From: Tony Lindgren <tony@atomide.com>
Subject: Re: SDP4430 nightly regression (was: Re: [GIT PULL] two omap
 regression fixes)
Date: Fri, 3 Nov 2017 09:05:18 -0700
Message-ID: <20171103160518.GG28152@atomide.com>
References: <pull-1509652473-291160@atomide.com>
 <20171103104316.GE28231@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171103104316.GE28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [171103 10:45]:
> I don't know if this is covered in your pull request, but since 31st
> October, the SDP4430 no longer recovers from a hibernation attempt.
> (as found by my nightly tests).

No I was not aware of any -rc series regressions, thanks for letting
me know.

> 4.14-rc6+ plus my tree plus arm-soc/for-next branch worked fine:
> 
> root@omap-4430sdp:~# if [ -f /sys/power/disk ]; then echo reboot > /sys/power/disk; echo disk > /sys/power/state; fi
> PM: hibernation entry
> PM: Syncing filesystems ...
> PM: done.
> Freezing user space processes ... (elapsed 0.022 seconds) done.
> OOM killer disabled.
> PM: Basic memory bitmaps created
> PM: Preallocating image memory... done (allocated 13293 pages)
> PM: Allocated 53172 kbytes in 0.17 seconds (312.77 MB/s)
> Freezing remaining freezable tasks ... (elapsed 0.016 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> omap_hwmod: gpio2: _wait_target_disable failed
> Disabling non-boot CPUs ...
> PM: Creating hibernation image:
> PM: Need to copy 13028 pages
> PM: Normal pages needed: 9836 + 1024, available pages: 53639
> PM: Hibernation image created (13028 pages copied)
> Enabling non-boot CPUs ...
> CPU1 is up
> PM: Cannot find swap device, try swapon -a.
> PM: Cannot get swap writer
> PM: Basic memory bitmaps freed
> OOM killer enabled.
> Restarting tasks ... done.
> PM: hibernation exit
> root@omap-4430sdp:~#
> 
> The above is an example of success - it's intentional that there's no
> swap, which prevents the system entering hibernation.  The purpose of
> this test is to exercise the PM and CPU hotplug paths.
> 
> 4.14-rc7+ plus my tree plus arm-soc/for-next now fails:
> 
> root@omap-4430sdp:~# if [ -f /sys/power/disk ]; then echo reboot > /sys/power/disk; echo disk > /sys/power/state; fi
> PM: hibernation entry
> PM: Syncing filesystems ...
> PM: done.
> Freezing user space processes ... (elapsed 0.022 seconds) done.
> OOM killer disabled.
> PM: Basic memory bitmaps created
> PM: Preallocating image memory... done (allocated 13200 pages)
> PM: Allocated 52800 kbytes in 0.17 seconds (310.58 MB/s)
> Freezing remaining freezable tasks ... (elapsed 0.015 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> 
> From what I can see, there's no change in arm-soc/for-next across that
> period - the same SHA1 hash was merged for the build tree update
> on the 27th October as was used on the 30th October.
> 
> There's no change (apart from the SHA hashes, the diff between them is
> empty) in the branch I merged between those two dates either for my
> tree.  The SHA hash change was due to squashing some MPS3 changes to
> fix a build error for the recently added mps3 build target in the
> builder.
> 
> The material difference is Linus' tip, which changed from f34157878d3b
> ("Merge tag 'nfs-for-4.14-4' of git://git.linux-nfs.org/projects/trondmy/linux-nfs")
> to 0b07194bb55e ("Linux 4.14-rc7").
> 
> In the diffstat between the two build trees (post merge), I don't see
> anything in arch/arm that could account for it.  I do see some power
> changes:
> 
>  drivers/base/power/domain_governor.c               |  53 +--
>  drivers/base/power/qos.c                           |   2 +-
>  drivers/base/power/runtime.c                       |   2 +-
>  drivers/base/power/sysfs.c                         |  25 +-
> 
> but nothing in tty or serial.  These power changes look like QoS
> changes, which probably aren't related.
> 
> Just to make sure, I've diffed the build tree SHAs and the change in
> Linus' tip, and the two diffs match apart from a couple of SHA blob
> hashes on a couple of files (EFI stub and MAINTAINERS).

Initiating git bisect sequence.

Regards,

Tony
