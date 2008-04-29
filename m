From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] PRCM: Combine 34xx l3_icks and l4_icks
Date: Tue, 29 Apr 2008 09:49:27 +0300
Message-ID: <87ej8p6tqg.fsf@trdhcp146196.ntc.nokia.com>
References: <873ap69ybi.fsf@trdhcp146196.ntc.nokia.com>
	<ce4301aed702935b2ce93992b362479e@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61435 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYD2GuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 02:50:01 -0400
In-Reply-To: <ce4301aed702935b2ce93992b362479e@felipebalbi.com> (ext Felipe
	Balbi's message of "Mon, 28 Apr 2008 05:49:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, ext Tony Lindgren <tony@atomide.com>, ext Paul Walmsley <paul@pwsan.com>, igor.stoppa@nokia.com

"ext Felipe Balbi" <me@felipebalbi.com> writes:

> On Mon, 28 Apr 2008 11:29:53 +0300, jouni.hogander@nokia.com (H=C3=B6=
gander
> Jouni) wrote:
>> E.g dss_l3_ick and dss_l4_ick have same gating control. Having own
>> clock for both of them causes race condition between enable / disabl=
e.
>>=20
>> This patch combines this kind of clocks and names new clock as
>> <module>_ick.
>>=20
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>
> Good, the following patch fixes ehci-omap.c after clock name change
> :-)

Sorry, I should have used grep here. I did it now. There are no
other references to changed clock names than this you pointed out. I
checked ca=E1=B8=BF_l3_ick, cam_l4_ick, usbhost_l3_ick, usbhost_l4_ick.

Yes, your patch needs to be applied if "[PATCH] PRCM: Combine 34xx
l3_icks and l4_icks" is applied.

>
> Could you check, please:
>
> From 4102f3ad5db10e662633c0f9ddee6aca43fec8e6 Mon Sep 17 00:00:00 200=
1
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Mon, 28 Apr 2008 13:45:49 +0300
> Subject: [PATCH] USB: EHCI: Fix clock name for ehci-omap.c
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>
> Patch from Jouni H=C3=B6gander changed usbhost_l4_ick to
> usbhost_ick, fixing in ehci-omap.c
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
> ---
>  drivers/usb/host/ehci-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-oma=
p.c
> index 495c979..be93c69 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -73,7 +73,7 @@ struct ehci_omap_clock_defs {
>  };
> =20
>  /* Clock names as per clock framework: May change so keep as #defs *=
/
> -#define USBHOST_ICKL	"usbhost_l4_ick"
> +#define USBHOST_ICKL	"usbhost_ick"
>  #define USBHOST_120M_FCLK	"usbhost_120m_fck"
>  #define USBHOST_48M_FCLK	"usbhost_48m_fck"
>  #define USBHOST_TLL_ICKL	"usbtll_ick"
> --=20
> 1.5.5.1.57.g5909c
>
>
>
> --=20
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
