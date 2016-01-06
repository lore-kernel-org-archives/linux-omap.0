From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Wed, 6 Jan 2016 08:41:36 -0800
Message-ID: <20160106164136.GI12777@atomide.com>
References: <cover.1451995297.git.hns@goldelico.com>
 <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
 <568C5451.8070709@ti.com>
 <20160106010011.GG12777@atomide.com>
 <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8FE6954B-6411-4593-9CE5-717A469A6AA8-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160106 00:12]:
> Am 06.01.2016 um 02:00 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > 
> > Also I'm not seeing just zeroes coming from RTC after typing hwclock
> > on omap5-uevm. It's working on x15 though.
> > 
> > Nikolaus, is hwclock command working for you on omap5-uevm?
> 
> Well, yes and no. It appears it *was* working when tested last time
> (we sometimes have months of delay for submitting patches upstream).
> 
> I have found an SD image with 4.3-rc6 with this patch in the dtb and
> there it works. With 4.4-rc8 it does not work. hwclock command hangs for
> 10 seconds (I guess some timeout).
> 
> I have checked the dtb and in both cases it is interrupts = <8 0>;
> 
> xxd /sys/firmware/devicetree/base/ocp/i2c@48070000/palmas@48/rtc/interrupts
> 0000000: 0000 0008 0000 0000
> 
> So I think something has changed in the rtc driver or somewhere else.

I just gave it a try on v4.3-rc6 with omap5-uevm.dts patched for
RTC, and I still don't have hwclock working with RTC.

It seems you have some additional patches there that make it work?

I guess it could also be a bootloader change if it's a different
SD image that works for you.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
