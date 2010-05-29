From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3 v3] AM35x: Add musb support
Date: Sat, 29 May 2010 16:24:55 +0400
Message-ID: <4C010797.8040207@mvista.com>
References: <4BFFCE8C.40909@ru.mvista.com> <579055.3526.qm@web180308.mail.gq1.yahoo.com> <19F8576C6E063C45BE387C64729E7394044E6D2537@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E6D2537-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Gupta, Ajay Kumar wrote:

>>>> AM35x has musb interface (version 1.8) and uses CPPI41
>>> DMA engine.
>>>> It has USB phy built inside the IP itself.

>> So it's more like DaVinci (earlier CPPI as well as
>> integrated PHY) than OMAP3...

> Yes. Actually they removed original musb controller from OMAP3
> and replaced it with DaVinci family musb ip.

    DA8xx/OMAP-L1x family actually. DaVinci has MUSB RTL 1.3 and CPPI 3.0, 
while DA8xx has RTL 1.8 and CPPI 4.1 like AM35x.

> -Ajay

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
