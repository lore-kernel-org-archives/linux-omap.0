From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Fri, 8 Jan 2016 19:32:54 +0100
Message-ID: <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com>
References: <cover.1451995297.git.hns@goldelico.com> <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com> <568C5451.8070709@ti.com> <20160106010011.GG12777@atomide.com> <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com> <20160106164136.GI12777@atomide.com> <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com> <20160106170925.GK12777@atomide.com> <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com> <20160108181551.GX12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160108181551.GX12777-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Am 08.01.2016 um 19:15 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:

> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160108 09:50]:
>> Tony,
>> it is strange. It now works under unknown conditions - without any obvoius change.
>> 
>> Am 06.01.2016 um 18:09 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>>> 
>>> OK. It could be also some .config change with something built-in?
>> 
>> I have compared /proc/config.gz from both systems and /sys/firmware/fdt
>> with no significant and obvious change.
>> 
>> Then I booted the 4.4-rc8 again and this time it worked.
>> 
>> To verify, I have checked out linux-next this morning, cherry-picked this palmas
>> rtc patch, compiled with omap2plus defconfig, and used the omap5-uevm.dtb. And
>> hwclock works after doing a modprobe rtc_palmas.
> 
> Weird. No luck here with current linux next or anything.
> 
>> Then I did the same with official v4.4-rc8 and hwclock hangs. And now our
>> 4.4-rc8 production kernel hangs again as well. Even if I use the
>> DTB from the 4.3 kernel.
> 
> I'm not seeing the RTC second increase in u-boot either, this
> should show it:
> 
> # i2c md 0x48 0x100
> 
> Of course the rtc may not be enabled in u-boot unlike for x15.
> 
>> So I think it is something which is unstable in 4.4-rc8 that is (probably) fixed in
>> linux-next and unrelated to this DT patch.
>> 
>> But I have no hint or idea what it is.
> 
> Or something hangs the RTC? And the back-up battery has to drain to
> reset the RTC somehow?

Indeed it could be something like this. I already suspected that it depends
on boot order of some components.

But you get the /dev/rtc and /sys/class/rtc nodes? This is what this patch
should enable (and not fix potential driver issues).

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
