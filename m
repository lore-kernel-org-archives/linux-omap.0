From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: State of SDP4430 platform
Date: Wed, 19 Jan 2011 20:56:33 +0530
Message-ID: <AANLkTinYuEoKNQZ_WRQ6Sd1S0CU4OKNGnxc6_Do3BW+M@mail.gmail.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com>
	<a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
	<ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
	<alpine.DEB.2.00.1101171611270.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33168 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752728Ab1ASP0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 10:26:35 -0500
Received: by qwj9 with SMTP id 9so969547qwj.27
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 07:26:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101171611270.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 4:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 17 Jan 2011, Santosh Shilimkar wrote:
>
>> The I2C timeout issue I could reproduce on my ES1.0 board. It's ES1.=
0
>> specific issue because I2C burst mode wasn't fuctional on it. Twl RT=
C
>> driver uses I2C burst mode and hence it times out. Other TWL I2C
>> module has no such issue.
>> The pull work-around we tried was not reliable hence it was dropped.
>>
>> In short the TWL RTC driver won't function on ES1.0. Apart from that
>> rest of the I2C clients should work as usual.
>
> Looks like the IRQ handling code uses it too:
>
> $ egrep -r 'twl_i2c_(write|read)\(' drivers/ | egrep -v twl-core | eg=
rep -v 4030
> drivers/mfd/twl6030-irq.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D twl_i2c=
_read(TWL_MODULE_PIH, sts.bytes,
> drivers/mfd/twl6030-irq.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D twl_i2c=
_write(TWL_MODULE_PIH, sts.bytes,
> drivers/mfd/twl6030-irq.c: =A0 =A0 =A0ret =3D twl_i2c_write(TWL_MODUL=
E_PIH, &mask[0],
> drivers/mfd/twl6030-irq.c: =A0 =A0 =A0ret =3D twl_i2c_write(TWL_MODUL=
E_PIH, &mask[0],
> drivers/mfd/twl6030-irq.c: =A0 =A0 =A0ret =3D twl_i2c_write(TWL_MODUL=
E_PIH, &mask[0],
> drivers/rtc/rtc-twl.c: =A0ret =3D twl_i2c_read(TWL_MODULE_RTC, rtc_da=
ta,
> drivers/rtc/rtc-twl.c: =A0ret =3D twl_i2c_write(TWL_MODULE_RTC, rtc_d=
ata,
> drivers/rtc/rtc-twl.c: =A0ret =3D twl_i2c_read(TWL_MODULE_RTC, rtc_da=
ta,
> drivers/rtc/rtc-twl.c: =A0ret =3D twl_i2c_write(TWL_MODULE_RTC, alarm=
_data,
> $
>
> I'd assume this also would affect other, non-TWL, I2C endpoints, no?
>

in ES1, timeouts were observed only with RTC.
I2C burst access to IRQ registers and bq24156 were OK

> Sounds like a platform_data flag should be passed into the I2C driver=
 code
> to indicate that burst transactions are buggy on OMAP4430ES1.
>
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
