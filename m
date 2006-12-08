From: Tony Lindgren <tony@atomide.com>
Subject: Patches sent upstream
Date: Thu, 7 Dec 2006 17:56:48 -0800
Message-ID: <20061208015647.GA23277@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've sent a big pile of patches to RMK, which should pretty much bring
all the core omap code in sync with mainline except for DSP and STI.

The patches can be viewed at:

http://www.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-upstream.git;a=shortlog;h=upstream-2006-12-07

And the list of patches follows.

Regards,

Tony


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patches

0001-ARM-OMAP2-Place-SMS-and-SDRC-into-smart-idle-mode.txt
0002-ARM-OMAP2-Force-APLLs-always-active.txt
0003-ARM-OMAP2-Add-DMA-IRQ-sanity-checks.txt
0004-ARM-OMAP-correct-misc-15xx-and-non-15xx-platform-code.txt
0005-ARM-OMAP-Enable-24xx-GPIO-autoidling.txt
0006-ARM-OMAP-Add-function-to-print-clock-usecounts.txt
0007-ARM-OMAP2-Enable-serial-idling-and-wakeup-features.txt
0008-ARM-OMAP2-Optimize-INTC-register-accesses-and-enable-autoidling.txt
0009-ARM-OMAP-FB-add-controller-platform-data.txt
0010-ARM-OMAP-Palm-Tungsten-E-board-update.txt
0011-ARM-OMAP-Fix-warning-in-clock.c.txt
0012-ARM-OMAP-Implement-workaround-for-GPIO-wakeup-bug-in-OMAP2420-silicon.txt
0013-ARM-OMAP-Proper-handling-of-DMA4_IRQSTATUS_L0.txt
0014-ARM-OMAP-Add-support-for-Amstrad-Delta-keypad.txt
0015-ARM-OMAP-Fix-apollon-boot.txt
0016-ARM-OMAP-sys-kernel-debug-omap_gpio.txt
0017-ARM-OMAP-omap2-memory.c-compile-fixes.txt
0018-ARM-OMAP-24xx-pinmux-updates.txt
0019-ARM-OMAP-omap2-gpmc-updates.txt
0020-ARM-OMAP-Enable-DSP-clocks-for-McBSP-on-omap310.txt
0021-ARM-OMAP-OMAP310-Serial.txt
0022-ARM-OMAP-PalmZ71-support.txt
0023-ARM-OMAP-No-IRQF_TRIGGER-set_type-function-for-IRQ-353-MPUIO.txt
0024-ARM-OMAP2-fix-apollon-gpmc-initialization.txt
0025-ARM-OMAP-Register-tsc2102-on-Palm-Tungsten-E.txt
0026-ARM-OMAP-gpio-init-section-cleanups.txt
0027-ARM-OMAP-gpio-object-shrinkage-cleanup.txt
0028-ARM-OMAP-Fix-warnings-in-plat-omap.txt
0029-ARM-OMAP-Fix-warning-in-mach-omap2.txt
0030-ARM-OMAP-Fix-Amstrad-Delta-omap-keypad-usage.txt
0031-ARM-OMAP-PalmZ71-extra-brace-fix.txt
0032-ARM-OMAP-Fix-typo-in-gpio.txt
0033-ARM-OMAP1-Fix-CONFIG_DEBUG_LL.txt
0034-ARM-OMAP-h4-must-have-blinky-leds.txt
0035-ARM-OMAP-abstract-debug-card-setup-smc-leds.txt
0036-ARM-OMAP-Fix-warning-in-mach-omap1.txt
0037-ARM-OMAP-omap-GP-timer-HZ-100.txt
0038-ARM-OMAP-Add-minimal-OMAP2430-support.txt
0039-ARM-OMAP-USB-peripheral-support-on-H4.txt
0040-ARM-OMAP-board-nokia770-correct-lcd-name.txt
0041-ARM-OMAP-Palm-Tungsten-T-support.txt
0042-ARM-OMAP-Palm-Zire71-minor-fixes.txt
0043-ARM-OMAP-plat-omap-changes-for-2430-SDP.txt
0044-ARM-OMAP-Basic-support-for-siemens-sx1.txt
0045-ARM-OMAP-This-patch-enables-I2C-2-support-for-2430-SDP.txt
0046-ARM-OMAP-Set-keypad-sense-delays-for-the-Palms.txt
0047-ARM-OMAP-speed-up-gpio-irq-handling.txt
0048-ARM-OMAP-Fix-typo-in-board-h4.h.txt
0049-ARM-OMAP-MPUIO-wake-updates.txt
0050-ARM-OMAP-Sync-headers-with-linux-omap.txt
0051-ARM-OMAP-Sync-core-code-with-linux-omap.txt
0052-ARM-OMAP-Sync-board-specific-files-with-linux-omap.txt
0053-ARM-OMAP-Add-support-for-boot-reason.txt
0054-ARM-OMAP-Add-support-for-a-procfs-entry-for-component-versions.txt
0055-ARM-OMAP-Debug-code-to-show-clock-usecounts.txt
0056-ARM-OMAP-Add-support-for-handling-GPIO-switches.txt
0057-ARM-OMAP-Avoid-updating-system-time-for-sub-jiffy-interrupts.txt
0058-ARM-OMAP-Tabify-mux.c.txt
0059-ARM-OMAP-TUSB-EVM-init.txt
0060-ARM-OMAP-Add-mailbox-support-for-IVA.txt
0061-ARM-OMAP-Add-DSP-common-code.txt
0062-ARM-OMAP-Update-omap-h2-defconfig.txt
0063-ARM-OMAP-Add-omap-osk-defconfig.txt

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--SUOF0GtieIMvvwua--
