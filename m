From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [GIT PULL] ARM: DTS: Fix OMAP bugs for 3.12-rc
Date: Wed, 18 Sep 2013 14:41:54 +0200
Message-ID: <52399F92.7040504@baylibre.com>
References: <52397523.4050209@baylibre.com> <CAFqH_52=NOZLHX4VZRMkUFpmJQJZ6egNZsckMJ=+QjVXO1=ofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFqH_52=NOZLHX4VZRMkUFpmJQJZ6egNZsckMJ=+QjVXO1=ofg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Enric

On 18/09/2013 12:24, Enric Balletbo Serra wrote:
> Hi Benoit,
>
>
> 2013/9/18 Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>:
>> Hi Tony,
>>
>> Please pull few fixes for OMAP DTS.
>>
>> Thanks,
>> Benoit
>>
>>
>>
>> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>>
>>    Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git tags/for_3.12-rc2/dts_signed
>>
>> for you to fetch changes up to 775d2418f309052641d94c896f73dc779cf7ba1b:
>>
>>    ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze (2013-09-18 11:14:42 +0200)
>>
>> ----------------------------------------------------------------
>> Fix BBB LDO voltage to avoid HDMI destruction
>> Fix OMAP5 wrong attribute
>> Fix typo in beagle xM strings
>>
>> ----------------------------------------------------------------
>> Felipe Balbi (2):
>>        ARM: dts: OMAP5: fix reg property size
>>        ARM: dts: OMAP5: fix ocp2scp DTS data
>>
>> Koen Kooi (1):
>>        ARM: dts: am335x-bone*: add DT for BeagleBone Black
>>
>> Robert Nelson (1):
>>        ARM: dts: omap3-beagle-xm: fix string error in compatible property
>>
>> Tony Lindgren (2):
>>        ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard
>>        ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze
>>
>>   arch/arm/boot/dts/Makefile                |   1 +
>>   arch/arm/boot/dts/am335x-bone-common.dtsi | 262 ++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/am335x-bone.dts         | 256 +----------------------------
>>   arch/arm/boot/dts/am335x-boneblack.dts    |  17 ++
>>   arch/arm/boot/dts/omap3-beagle-xm.dts     |   2 +-
>>   arch/arm/boot/dts/omap4-panda-common.dtsi |  46 +++++-
>>   arch/arm/boot/dts/omap4-sdp.dts           |  39 ++++-
>>   arch/arm/boot/dts/omap5.dtsi              |   7 +-
>>   8 files changed, 369 insertions(+), 261 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/am335x-bone-common.dtsi
>>   create mode 100644 arch/arm/boot/dts/am335x-boneblack.dts
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> On July 5th, I sent the following patch
>
>      http://www.spinics.net/lists/linux-omap/msg96935.html
>
> and on Sep 10th I sent the same patch rebased with upstream and Acked
> by Javier. I consider this patch as a fix, as is required to make the
> sound work on IGEP boards but it's not included in this pull request.
> Maybe you forget it due your email change. Can you consider adding
> this patch, at least, in your next pull request? Thanks in advance.

Sorry I missed it, and will send an updated pull-request in five minutes 
from now... If you do not see anything from me after 6 minutes you can 
complain.

> Merci beaucoup,

De rien.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
