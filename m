From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] [PATCH 5/7] omap: usb: ehci: Initialize resources for
 omap4
Date: Fri, 20 Aug 2010 08:39:47 +0300
Message-ID: <20100820053947.GC15196@nokia.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1282175377-2784-6-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 19, 2010 at 01:49:35AM +0200, ext Keshava Munegowda wrote:
>@@ -328,8 +321,25 @@ void __init usb_ehci_init(const struct e
> 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
>
> 	/* Setup Pin IO MUX for EHCI */
>-	if (cpu_is_omap34xx())
>+	if (cpu_is_omap34xx()) {
>+		ehci_resources[0].start	= OMAP34XX_EHCI_BASE;
>+		ehci_resources[0].end	= OMAP34XX_EHCI_BASE + SZ_1K - 1;
>+		ehci_resources[1].start	= OMAP34XX_UHH_CONFIG_BASE;
>+		ehci_resources[1].end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
>+		ehci_resources[2].start	= OMAP34XX_USBTLL_BASE;
>+		ehci_resources[2].end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1;
>+		ehci_resources[3].start = INT_34XX_EHCI_IRQ;
> 		setup_ehci_io_mux(pdata->port_mode);

rename this to setup_3430ehci_io_mux() while at that.

-- 
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
