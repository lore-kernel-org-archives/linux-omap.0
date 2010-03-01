From: "Maulik" <x0082077-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Mon, 1 Mar 2010 11:11:29 +0530
Message-ID: <001b01cab901$dadec9a0$808918ac@apr.dhcp.ti.com>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com> <20100225184833.GG28173@atomide.com> <20100226004233.GA3241@lixom.net> <000001cab6bf$5df75720$808918ac@apr.dhcp.ti.com> <20100226185414.GA10835@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100226185414.GA10835-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Olof Johansson' <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Felipe Balbi' <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-l3A5Bk7waGM@public.gmane.org>, 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Olof,
> 
> We have such an option "USB_MUSB_SOC" that takes care of all platforms
where
> MUSB is present. But the Inventra DMA case is typical. Not all
architectures
> that have MUSB use Inventra DMA for e.g Davinci uses CPPI DMA.

>>Yeah, sorry. I didn't mean the INVENTRA_DMA config option as much as the
>>top
>>MUSB one. So you should be able to switch to that instead of adding a
>>check for
>>OMAP4 there then?

Olof,
So you suggest adding something like below for OMAP4 and all others as well
right?

comment "OMAP 44xx high speed USB support"
        depends on USB_MUSB_HDRC && USB_MUSB_SOC

Regards,
Maulik

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
