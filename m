From: Steven Ziegler <skziegler2@gmail.com>
Subject: Problems with A/D Converter (twl4030-madc driver?)
Date: Wed, 12 May 2010 12:57:30 -0500
Message-ID: <AANLkTikrm9nFWp9h1507Mwr-OtAkBb5pIwBDGHYz_QYs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41095 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0ELR5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 13:57:32 -0400
Received: by vws4 with SMTP id 4so76042vws.19
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 10:57:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have been having some issues with the A/D converter on the OMAP3530
platform, using the TWL4030.=C2=A0 The hardware I am using is the Logic
OMAP3530 LV SOM Zoom2 Development Kit.=C2=A0 I created a driver which u=
ses
the twl4030-madc driver to obtain the A/D values for ADCIN3 and
ADCIN4.=C2=A0 I am not getting valid values back from the MADC driver.=C2=
=A0 For
instance, I am getting 0 for ADCIN3 and 24496 for ADCIN4.=C2=A0 (24496 =
is
obviously wrong as it is out of the range of the 10-bit A/D...)=C2=A0 E=
ven
if I vary the voltage on these inputs, I get the same results.=C2=A0 He=
re
is the structure that I am sending into the twl4030_conversion()
function:

// ** start code

=C2=A0=C2=A0=C2=A0 struct twl4030_madc_request req;
=C2=A0=C2=A0=C2=A0 int tempX, tempY;

=C2=A0=C2=A0=C2=A0 req.channels =3D 0x0000 | TWL4030_MADC_ADCIN3 | TWL4=
030_MADC_ADCIN4;
=C2=A0=C2=A0=C2=A0 req.do_avg =3D 0;
=C2=A0=C2=A0=C2=A0 req.method =3D TWL4030_MADC_SW1;
=C2=A0=C2=A0=C2=A0 req.active =3D 0;
=C2=A0=C2=A0=C2=A0 req.type =3D TWL4030_MADC_WAIT;
=C2=A0=C2=A0=C2=A0 req.func_cb =3D NULL;
=C2=A0=C2=A0=C2=A0 twl4030_madc_conversion(&req);
=C2=A0=C2=A0=C2=A0 if(&req =3D=3D NULL)
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("req is NULL after co=
nversion request!\n");
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 else if(req.rbuf =3D=3D NULL)
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("req.rbuf is NULL aft=
er conversion request!\n");
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 else
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tempX =3D (u16)req.rbuf[4];
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tempY =3D (u16)req.rbuf[3];

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("Received A/D values,=
 tempX =3D %d, tempY =3D %d\n", tempX, tempY);
=C2=A0=C2=A0=C2=A0 }

// ** end code

I also tried implementing two other versions using 'req.channels =3D
TWL4030_MADC_ADCIN3' or 'req.channels =3D TWL4030_MADC_ADCIN4' instead
of the combined version shown above and I am getting the same bogus
results.

Is there some issue with what I am doing here?

Has anyone successfully utilized this driver?

I looked into the issue further by sending/receiving i2c commands
straight to the TWL4030 using i2cset and i2cget in a shell script.
Here is the sequence of commands that I used:

# ** start shell script
i2cset -f -y 1 0x49 0x91 0x90
i2cset -f -y 1 0x4a 0x00 0x01
i2cset -f -y 1 0x4a 0x06 0xff
i2cset -f -y 1 0x4a 0x07 0xff
i2cset -f -y 1 0x4a 0x97 0x02
i2cset -f -y 1 0x4a 0x12 0x20

sleep 1

GPCH3_LSB=3D`i2cget -f -y 1 0x4a 0x3d`
GPCH3_MSB=3D`i2cget -f -y 1 0x4a 0x3e`

GPCH4_LSB=3D`i2cget -f -y 1 0x4a 0x3f`
GPCH4_MSB=3D`i2cget -f -y 1 0x4a 0x40`

let ADC3=3D`printf %d $GPCH3_LSB`/64+`printf %d $GPCH3_MSB`*4
let ADC4=3D`printf %d $GPCH4_LSB`/64+`printf %d $GPCH4_MSB`*4

let VAL3=3D($ADC3*2444)/1000
let VAL4=3D($ADC4*2444)/1000

echo "ADC3=C2=A0 value is $ADC3 , $VAL3 millivolts=C2=A0=C2=A0=C2=A0 GP=
 analog input"
echo "ADC4=C2=A0 value is $ADC4 , $VAL4 millivolts=C2=A0=C2=A0=C2=A0 GP=
 analog input"
# ** end shell script

=46rom this script, I am getting 6 for both ADC outputs, even with
varying voltages.

Is there something I am doing wrong here?

Any help would be greatly appreciated.=C2=A0 Thanks in advance.

-Steve Ziegler
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
