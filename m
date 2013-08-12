From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: update =?UTF-8?B?QmVub8OudCBDb3Vz?=
 =?UTF-8?B?c29uIGVtYWlsIGFkZHJlc3M=?=
Date: Mon, 12 Aug 2013 16:15:00 +0200
Message-ID: <5208EDE4.7030303@baylibre.com>
References: <1376234465-15476-1-git-send-email-javier.martinez@collabora.co.uk> <20130812075556.GH7656@atomide.com> <CAAwP0s3bt3EiA60UPL3StcRuFHF2pgD6A7DpEkoFkud59tNzEA@mail.gmail.com> <CAAwP0s3PXJ7r7UspZbff3ymvn_Z3ySoeTGD_84_trV3gethD9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:44049 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204Ab3HLOPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 10:15:05 -0400
Received: by mail-we0-f176.google.com with SMTP id q56so5531974wes.35
        for <linux-omap@vger.kernel.org>; Mon, 12 Aug 2013 07:15:04 -0700 (PDT)
In-Reply-To: <CAAwP0s3PXJ7r7UspZbff3ymvn_Z3ySoeTGD_84_trV3gethD9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jiri Kosina <jkosina@suse.cz>, benoit.cousson@gmail.com, =?UTF-8?B?QmVubw==?= =?UTF-8?B?w650IENvdXNzb24=?= <benoit.cousson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, linux-omap@vger.kernel.org

Hi Javier,

Thanks for taking care of that. Sorry if I missed you for so long :-)

I had to manage TI layoffs then vacation then starting my new job.

On 12/08/2013 16:03, Javier Martinez Canillas wrote:
> On Mon, Aug 12, 2013 at 11:09 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
>> Hi Tony,
>>
>> On Mon, Aug 12, 2013 at 9:55 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>>> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [13081=
1 08:28]:
>>>> Using the email address listed on MAINTAINERS I keep
>>>> getting SMTP 550 Invalid recipient errors.
>>>>
>>>> Update with what seems to be current Beno=C3=AEt's email
>>>> address to make get_maintainer.pl to stop lying.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora=
=2Eco.uk>
>>>
>>> Is the linaro.org address still valid? We should probably
>>> wait for Benoit to confirm this to avoid more confusion.
>>>
>>
>> It seems so, at least I don't get SMTP 550 errors with it. But I agr=
ee
>> that is best to wait for Benoit to confirm what is his current
>> address. I just wanted to help...
>>
>
> I see that Benoit also has a gmail address. I'm cc'ing him in this
> thread so he can confirm what is his current email address and
> MAINTAINERS can be updated so people can send OMAP DT patches to the
> correct address.
>
> Thanks a lot and best regards,
> Javier


Here is my official new email address.

I'll repost it properly, except if Tony is fine taking it like that.

Regards,
Benoit

---
 From 8a5464b6da7f076b7caa21ac96905b46cf26e269 Mon Sep 17 00:00:00 2001
=46rom: Benoit Cousson <bcousson@baylibre.com>
Date: Fri, 9 Aug 2013 23:19:15 +0200
Subject: [PATCH] MAINTAINERS: Update my email address

Goodbye TI. Welcome new life!

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
  MAINTAINERS | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cacc88..300c9f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5884,7 +5884,7 @@ F:	drivers/i2c/busses/i2c-omap.c
  F:	include/linux/i2c-omap.h

  OMAP DEVICE TREE SUPPORT
-M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Beno=C3=AEt Cousson <bcousson@baylibre.com>
  M:	Tony Lindgren <tony@atomide.com>
  L:	linux-omap@vger.kernel.org
  L:	devicetree@vger.kernel.org
@@ -5964,14 +5964,14 @@ S:	Maintained
  F:	drivers/char/hw_random/omap-rng.c

  OMAP HWMOD SUPPORT
-M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Beno=C3=AEt Cousson <bcousson@baylibre.com>
  M:	Paul Walmsley <paul@pwsan.com>
  L:	linux-omap@vger.kernel.org
  S:	Maintained
  F:	arch/arm/mach-omap2/omap_hwmod.*

  OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
-M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Beno=C3=AEt Cousson <bcousson@baylibre.com>
  L:	linux-omap@vger.kernel.org
  S:	Maintained
  F:	arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--=20
1.8.1.2


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
