From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not
 stable, disable it
Date: Thu, 12 Jul 2012 14:03:40 +0530
Message-ID: <CAP05o4JVWPQjx4srob7jhBTepa8URX4tpOmLyNTpWdaw3pTQ3A@mail.gmail.com>
References: <1341598828-31410-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36638 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392Ab2GLIdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 04:33:43 -0400
Received: by lbbgj10 with SMTP id gj10so3008469lbb.9
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 01:33:40 -0700 (PDT)
In-Reply-To: <1341598828-31410-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 6, 2012 at 11:50 PM, Kevin Hilman <khilman@ti.com> wrote:
> The EHCI driver is not stable enough to be enabled by default.  In v3.5,
> it has at least the following problems:
>
> - warning dump during bootup
> - hang during suspend
> - prevents CORE powerdomain from entering retention during idle (even
>   when no USB devices connected.)
>
> This demonstrates that this driver has not been thoroughly tested and
> therfore should not be enabled in the default defconfig.
>
> In addition, the problems above cause new PM regressions which need be
> addressed before this driver should be enabled in the default
> defconfig.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, this applies to your current fixes branch.   Please queue up for v3.5-rc
> so this PM regression is fixed in v3.5.  Thanks.
>
>  arch/arm/configs/omap2plus_defconfig |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 9854ff4..11828e6 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -176,7 +176,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_DEVICEFS=y
>  CONFIG_USB_SUSPEND=y
>  CONFIG_USB_MON=y
> -CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_WDM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_LIBUSUAL=y
> --
> 1.7.9.2
>


hi Kevin
   This patch is good. But , in  my earlier patch I was disabling the
dependent configuration of ehci too.

- CONFIG_USB=y
                - removes the usb host  ( EHCI is the only host),
hence keeping it enabled with ehci does not make sense for
                        omap2 defconfig

-CONFIG_USB_DEBUG=y
                   - Enables the debug messages for usb host

-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_DEVICEFS=y
                    Announces the new devices attached to ehci; if usb
host it self is not there, then we dont need it.

-CONFIG_USB_SUSPEND=y
                   - suspend resume of usb host; not required if ehci
itself is not existing

-CONFIG_USB_MON=y
                   - usb monitor

-CONFIG_USB_WDM=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_LIBUSUAL=y
-CONFIG_USB_TEST=y
              - usb storage and test ; again dependent on ehci only in
omap2plusdefconfig.

for omap build, if you disabling ehci , its good have not include
these modules; yet including these modules does not harm anything.

regards
keshava
