From: "Maulik" <x0082077-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Wed, 10 Mar 2010 15:47:08 +0530
Message-ID: <00f701cac03a$da51cab0$808918ac@apr.dhcp.ti.com>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com> <20100225184833.GG28173@atomide.com> <20100226004233.GA3241@lixom.net> <000001cab6bf$5df75720$808918ac@apr.dhcp.ti.com> <20100226185414.GA10835@lixom.net> <001b01cab901$dadec9a0$808918ac@apr.dhcp.ti.com> <20100301154329.GA4154@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100301154329.GA4154-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Olof Johansson' <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Felipe Balbi' <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-l3A5Bk7waGM@public.gmane.org>, 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


>Hmm. I must be missing something, but it looks odd to have both the
>USB_MUSB_HDRC and USB_MUSB_SOC high-level config options, especially since
>the depends are duplicated across them.

>In general, options like these tend to scale badly:

>config USB_MUSB_SOC
 >       boolean
 >       depends on USB_MUSB_HDRC
 >       default y if ARCH_DAVINCI
 >       default y if ARCH_OMAP2430
 >      default y if ARCH_OMAP34XX
 >       default y if (BF54x && !BF544)
 >       default y if (BF52x && !BF522 && !BF523)

>I.e. every single platform needs to add a new line. It's better
>to have a config option that is selected from the platform code
>(arch/arm/mach-omap2/Kconfig for the specific SOC in this case), that

Olof,

I agree with this. Since this change will impact many platforms it will
require thorough testing and review. Can we have OMAP4 MUSB driver support 
queued up without this Kconfig enhancement? I believe the driver patches can

go in independent of this enhancement.

Regards,
Maulik


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
