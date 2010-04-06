From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] omap: Add OHCI USB platform init for OMAP2430
Date: Tue, 6 Apr 2010 09:48:27 +0300
Message-ID: <20100406064827.GR16297@nokia.com>
References: <70376CA23424B34D86F1C7DE6B9973430254343A3B@VSHINMSMBX01.vshodc.lntinfotech.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <70376CA23424B34D86F1C7DE6B9973430254343A3B-fVvhrSDAkVjuuPCCJ6VnObSn4PsL5ZDKvpI+GvaZM4lBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 06, 2010 at 08:25:25AM +0200, ext Viral Mehta wrote:
>Add platform init code for OHCI USB on OMAP2430
>
>Signed-off-by: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>

this one too

>---
> arch/arm/mach-omap2/board-2430sdp.c |   10 ++++++++++
> 1 files changed, 10 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
>index 346e1d2..047d5ae 100644
>--- a/arch/arm/mach-omap2/board-2430sdp.c
>+++ b/arch/arm/mach-omap2/board-2430sdp.c
>@@ -206,6 +206,15 @@ static struct omap_musb_board_data musb_board_data = {
>        .mode                   = MUSB_OTG,
>        .power                  = 100,
> };
>+static struct omap_usb_config sdp2430_usb_config __initdata = {
>+       .otg            = 1,
>+#ifdef  CONFIG_USB_GADGET_OMAP
>+       .hmc_mode       = 0x0,
>+#elif   defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
>+       .hmc_mode       = 0x1,
>+#endif
>+       .pins[0]        = 3,
>+}
>
> static void __init omap_2430sdp_init(void)
> {
>@@ -216,6 +225,7 @@ static void __init omap_2430sdp_init(void)
>        platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
>        omap_serial_init();
>        omap2_hsmmc_init(mmc);
>+       omap_usb_init(&sdp2430_usb_config);
>        usb_musb_init(&musb_board_data);
>        board_smc91x_init();
>
>--
>1.6.6
>
>This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>
>______________________________________________________________________
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
