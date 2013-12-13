From: "Kwok, WingMan" <w-kwok2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Fri, 13 Dec 2013 16:04:38 +0000
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C786@DFLE11.ent.ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com> <52AA54E4.5000606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52AA54E4.5000606-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello

> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Thursday, December 12, 2013 7:29 PM
> To: Balbi, Felipe
> Cc: Linux USB Mailing List; kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; Linux ARM Kernel
> Mailing List; linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linux OMAP Mailing List;
> Kwok, WingMan
> Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
> 
> On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > A bare-minimum PM implementation which will server as building block
> > for more complex
> s/server/serve ;-)
> > PM implementation in the future.
> >
> > At the least will not leave clocks on unnecessarily when e.g.  a user
> > write mem to /sys/power/state.
> >
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >
> > improve error path a little bit.
> >
> We will test this out. Thanks for the
> patch Felipe.
> 

I have tested the patch and the keystone usb driver continues to function,
though I can't test suspend at this time as the rest of the system does
not that functionality yet.

Thanks
WingMan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
