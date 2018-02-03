From: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Sun, 4 Feb 2018 00:10:50 +0100
Message-ID: <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
References: <20180204000335.29812776@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180204000335.29812776-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Sun, Feb 4, 2018 at 12:03 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:
> Hi,
>
> I booted a 4.15 kernel without udev and loaded modules piece by piece to analyze
> pm problems. modprobe ehci-omap increases current by around 35mA and
> also rmmod ehci-omap does not let it go down at all.
>
> I expect that removing hardware does the same thing
>
> Also suspend current increases by around 15mA if that module is loaded.
> I tested with having everything disabled which is attached to that usb bus.
>

Do you have an LTE connected to the usb?

Michael

> System was
> GTA04A5 (with dm3730 processor and usb3322 phy)
>
> I know it has worked once, but I do not remember the version.
>
> The kernel config used can be found here:
> http://misc.andi.de1.cc/config-4.15.gz
>
> Regards
> Andreas
> BTW: I am at the FOSDEM, will probably spend a lot of time in the
> hw enablement devroom. So maybe ideas could be discussed directly.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
