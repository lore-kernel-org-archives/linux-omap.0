From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Fri, 8 Jan 2016 18:49:31 +0100
Message-ID: <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com>
References: <cover.1451995297.git.hns@goldelico.com> <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com> <568C5451.8070709@ti.com> <20160106010011.GG12777@atomide.com> <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com> <20160106164136.GI12777@atomide.com> <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com> <20160106170925.GK12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160106170925.GK12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Tony,
it is strange. It now works under unknown conditions - without any obvoius change.

Am 06.01.2016 um 18:09 schrieb Tony Lindgren <tony@atomide.com>:

> * H. Nikolaus Schaller <hns@goldelico.com> [160106 08:48]:
>> Hi Tony,
>> 
>> Am 06.01.2016 um 17:41 schrieb Tony Lindgren <tony@atomide.com>:
>> 
>>> Hi,
>>> 
>>> * H. Nikolaus Schaller <hns@goldelico.com> [160106 00:12]:
>>>> Am 06.01.2016 um 02:00 schrieb Tony Lindgren <tony@atomide.com>:
>>>>> 
>>>>> Also I'm not seeing just zeroes coming from RTC after typing hwclock
>>>>> on omap5-uevm. It's working on x15 though.
>>>>> 
>>>>> Nikolaus, is hwclock command working for you on omap5-uevm?
>>>> 
>>>> Well, yes and no. It appears it *was* working when tested last time
>>>> (we sometimes have months of delay for submitting patches upstream).
>>>> 
>>>> I have found an SD image with 4.3-rc6 with this patch in the dtb and
>>>> there it works. With 4.4-rc8 it does not work. hwclock command hangs for
>>>> 10 seconds (I guess some timeout).
>>>> 
>>>> I have checked the dtb and in both cases it is interrupts = <8 0>;
>>>> 
>>>> xxd /sys/firmware/devicetree/base/ocp/i2c@48070000/palmas@48/rtc/interrupts
>>>> 0000000: 0000 0008 0000 0000
>>>> 
>>>> So I think something has changed in the rtc driver or somewhere else.
>>> 
>>> I just gave it a try on v4.3-rc6 with omap5-uevm.dts patched for
>>> RTC, and I still don't have hwclock working with RTC.
>>> 
>>> It seems you have some additional patches there that make it work?
>> 
>> Hm. Not that I am aware of. We just did add the rtc nodes but did not
>> touch palmas drivers (except adding the gpadc of this patch series).
> 
> OK
> 
>>> I guess it could also be a bootloader change if it's a different
>>> SD image that works for you.
>> 
>> Yes, it is using a 2 years old U-Boot instead 2015.10 compiled from
>> source. I will try to find out if it makes a difference.
> 
> OK. It could be also some .config change with something built-in?

I have compared /proc/config.gz from both systems and /sys/firmware/fdt
with no significant and obvious change.

Then I booted the 4.4-rc8 again and this time it worked.

To verify, I have checked out linux-next this morning, cherry-picked this palmas
rtc patch, compiled with omap2plus defconfig, and used the omap5-uevm.dtb. And
hwclock works after doing a modprobe rtc_palmas.

Then I did the same with official v4.4-rc8 and hwclock hangs. And now our
4.4-rc8 production kernel hangs again as well. Even if I use the
DTB from the 4.3 kernel.

So I think it is something which is unstable in 4.4-rc8 that is (probably) fixed in
linux-next and unrelated to this DT patch.

But I have no hint or idea what it is.

BR,
Nikolaus
