From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 00/21] ARM: OMAP2+: Adapt to ehci-omap changes for
 3.10
Date: Fri, 5 Apr 2013 10:30:17 +0200
Message-ID: <515E8B99.8080803@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363794300-31526-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 03/20/2013 04:44 PM, Roger Quadros wrote:
> Hi Tony,
> 
> These patches provide the SoC side code required to support
> the changes in the OMAP USB Host drivers done in [1], [2] & [3].
> 
> Device tree support is added for Beagleboard only. I've removed
> Panda device tree support till we have resolved the AUXCLK issue.
> 
> NOTE: The first patch needs to be shared between the
> OMAP tree and Felipe's USB tree.
> 
> v4:
> - Some more cleanup to usbhs_init_phys(). Moved repeated code into
> another helper function usbhs_add_regulator().
> - Removed patch for Panda device tree support for USB host since
> it is non functional.
> 
> v3:
> - Moved more functionality into usbhs_init_phys().
> 
> v2:
> - Added helper function usbhs_init_phys() that can be used by board files
> to simplify adding of PHY regulators for USB host ports.
> 
> [1] MFD side changes to omap-usb-host and omap-usb-tll
>   https://lkml.org/lkml/2013/3/12/179
> [2] USB EHCI side changes to ehci-omap 
>   http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg86265.html
> [3] USB PHY driver changes
>   http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg86293.html
> 
> The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
> 
>   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git usbhost-arm-next
> 
> Roger Quadros (21):
>   usb: phy: nop: Add some parameters to platform data
>   ARM: OMAP2+: omap-usb-host: Add usbhs_init_phys()
>   ARM: OMAP2+: omap4panda: Adapt to ehci-omap changes
>   ARM: OMAP3: Beagle: Adapt to ehci-omap changes
>   ARM: OMAP3: 3430SDP: Adapt to ehci-omap changes
>   ARM: OMAP3: 3630SDP: Adapt to ehci-omap changes
>   ARM: OMAP: AM3517crane: Adapt to ehci-omap changes
>   ARM: OMAP: AM3517evm: Adapt to ehci-omap changes
>   ARM: OMAP3: cm-t35: Adapt to ehci-omap changes
>   ARM: OMAP3: cm-t3517: Adapt to ehci-omap changes
>   ARM: OMAP: devkit8000: Adapt to ehci-omap changes
>   ARM: OMAP3: igep0020: Adapt to ehci-omap changes
>   ARM: OMAP3: omap3evm: Adapt to ehci-omap changes
>   ARM: OMAP3: omap3pandora: Adapt to ehci-omap changes
>   ARM: OMAP3: omap3stalker: Adapt to ehci-omap changes
>   ARM: OMAP3: omap3touchbook: Adapt to ehci-omap changes
>   ARM: OMAP3: overo: Adapt to ehci-omap changes
>   ARM: OMAP: zoom: Adapt to ehci-omap changes
>   ARM: dts: OMAP4: Add HS USB Host IP nodes
>   ARM: dts: OMAP3: Add HS USB Host IP nodes
>   ARM: dts: omap3-beagle: Add USB Host support

These 3 DTS patches are good to me, but I cannot applied them on top of
the already existing patches I queued for 3.10.

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
for_3.10/dts

Could you rebase these 3 ones only, and I will applied them.

Thanks,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
