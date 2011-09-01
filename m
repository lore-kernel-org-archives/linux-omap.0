From: Marc Dietich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Thu, 1 Sep 2011 13:13:41 +0200
Message-ID: <201109011313.42547.marvin24@gmx.de>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com> <201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de> <4E5F5FA9.3010305@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5F5FA9.3010305-5wv7dgnIgG8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Hi Marc,

^dito,

> On 31/08/11 17:55, Marc Dietrich wrote:
> > Am Mittwoch 31 August 2011, 18:12:48 schrieb Marc Zyngier:
> >> [...]
> >> Oddly enough, this patch doesn't do anything on my Tegra setup. In both
> >> cases, I get around 17MB/s from a crap SD card plugged in a USB reader.
> >> 
> >> This leads me to suspect that this issue is very much OMAP4 specific.
> >> Can anyone verify this theory on other some A9 platforms?
> > 
> > That's odd. On my Tegra2 (on ac100) it boosts the transfer rate from 7 to
> > 17 MB/s.
> 
> I'm using a Harmony board. Could you share your kernel version, .config
> and dmesg?
> 
> Thanks,
> 
> 	M.

I use the chromiumos tree (for chromiumos 2.6.38 kernel: 
http://git.chromium.org/chromiumos/third_party/kernel-next.git) with some 
additions to make it run on the AC100. This modified tree is on 
git://gitorious.org/~marvin24/ac100/marvin24s-kernel.git. The config is 
paz00_defconfig and a dmesg you can get e.g. from http://pastebin.com/9uVfDWma
(it's not very current, but it should be sufficient).

I'll add Stephen Warren from NVIDIA to the CC list. He has more HW to test on. 

Btw, this is the patch I used: http://gitorious.org/~marvin24/ac100/marvin24s-
kernel/commit/cce8d9e25d009a45c219a6ad0b9ac4e27d034ab0

	Marc
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
