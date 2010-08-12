From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 12 Aug 2010 06:56:02 -0500
Message-ID: <AANLkTinmEyKmVSGxujTGtGSEdUk7HvB3OgRrzVzZ1enq@mail.gmail.com>
References: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
	<20100812100349.8f151b5b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64256 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933598Ab0HLL4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 07:56:03 -0400
Received: by ewy23 with SMTP id 23so565304ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 04:56:02 -0700 (PDT)
In-Reply-To: <20100812100349.8f151b5b.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Thu, Aug 12, 2010 at 2:03 AM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> Hi
>
> On Wed, 11 Aug 2010 18:37:40 -0500
> Robert Nelson <robertcnelson@gmail.com> wrote:
>
>> Due to the omap3530 ES3.0 Silicon being used on both the
>> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx()
>> routines to differentiate the Beagle Boards.
>>
>> However gpio pins 171,172,173 where setup for this prupose, so
>> lets use them.
>>
>> Tested on Beagle Revisions: B5, C2, C4, and xMA
>>
>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>> ---
>> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 60 ++++++++++++++++=
+++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/board.h | =A0 23 ++++++++++++
>> =A02 files changed, 83 insertions(+), 0 deletions(-)
>>
> ...
>> + =A0 =A0 beagle_rev =3D gpio_get_value(171) | (gpio_get_value(172) =
<< 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (gpio_get_value(173) << =
2);
>> +
>> + =A0 =A0 switch (beagle_rev) {
>> + =A0 =A0 case 7:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_beagle_version =3D OMAP3BEAGLE_BOARD=
_AXBX;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 6:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/=
C3\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_beagle_version =3D OMAP3BEAGLE_BOARD=
_C1_3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 5:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: C4\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_beagle_version =3D OMAP3BEAGLE_BOARD=
_C4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: xM\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_beagle_version =3D OMAP3BEAGLE_BOARD=
_XM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: unknow=
n %hd\n", beagle_rev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_beagle_version =3D OMAP3BEAGLE_BOARD=
_XM;
>> + =A0 =A0 }
>
> My C2 reads as 2 and I have U-Boot 2009.01-dirty (Feb 19 2009 -
> 12:22:31). I believe these pins are not muxed correctly with that
> U-Boot version.

Thanks for testing Jarkko, i had been using U-Boot 2010.03.. So it
looked like we could use the more generic gpio routines, but i'll swap
to the omap_mux_init_gpio and retest on my systems..

>
> Therefore kernel should remux those pins so that version is detected
> right independently of bootloader version. Detections works fine if I
> add these:
>
> =A0 =A0 =A0 =A0omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
> =A0 =A0 =A0 =A0omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
> =A0 =A0 =A0 =A0omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
>
>
> --
> Jarkko
>



--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
