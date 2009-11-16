From: =?ISO-8859-1?Q?Fr=E9d=E9ric_BEGOU?= <fbegou@sios.fr>
Subject: Re: [PATCH 1/2 (for-next)] ARM: OMAP3: Add support for the IGEP v2
 board (rev B)
Date: Mon, 16 Nov 2009 15:31:14 +0100
Message-ID: <4B016232.60607@sios.fr>
References: <4B015F12.7080709@sios.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp28.orange.fr ([80.12.242.101]:56112 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbZKPObB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Nov 2009 09:31:01 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2827.orange.fr (SMTP Server) with ESMTP id 4546E80000AE
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 15:31:01 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2827.orange.fr (SMTP Server) with ESMTP id 3935C8000052
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 15:31:01 +0100 (CET)
Received: from [192.168.48.102] (LPuteaux-151-43-16-109.w217-128.abo.wanadoo.fr [217.128.255.109])
	by mwinf2827.orange.fr (SMTP Server) with ESMTP id AAB348000063
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 15:31:00 +0100 (CET)
In-Reply-To: <4B015F12.7080709@sios.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

=46r=E9d=E9ric BEGOU wrote :
> Fr=E9d=E9ric BEGOU wrote:
>
>    Hello,
>
>    =20
>    For what I've seen on the Internet concerning your card, there is
>    only one MMC card reader.
>
>    Besides, there is the following piece of code :
>
>    =20
>        +static struct twl4030_hsmmc_info mmc[] =3D {
>        +       {
>        +               .mmc            =3D 1,
>        +               .wires          =3D 4,
>        +               .gpio_cd        =3D -EINVAL,
>        +               .gpio_wp        =3D -EINVAL,
>        +       },
>        +       {
>        +               .mmc            =3D 2,
>        +               .wires          =3D 4,
>        +               .gpio_cd        =3D -EINVAL,
>        +               .gpio_wp        =3D -EINVAL,
>        +       },
>        +       {}      /* Terminator */
>        +};
>          =20
>    Maybe I am mistaken, but doesn't that mean there are two MMC cards=
 ?
>
>    =20
>    I am interested in the subject, as I am trying to write my own boa=
rd
>    file for our custom, beagleboard-based card, with no success so fa=
r
>    concerning the second MMC reader...
>
> Well, it seems that the board is question has a WIFI module connected=
=20
> to the second mmc. What is your problem right now ? Remember that all=
=20
> three MMC slots are different in what kind of voltage they can drive.
>
Hello,

OK I understand for your board.

I have my second MMC slot wired just like MMC1 : they are micro-SD slot=
s=20
wired with
- MMC2_CLK
- MMC2_CMD
- MMC2_DATA0
- MMC2_DATA1
- MMC2_DATA2
- MMC2_DATA3 , all 6 wired with a 4.7Kohm resistor to VMMC2 ;

VDD wired to VMMC2 and VSS to ground.
Add a capacitor between VMMC2 and the ground for the taste !

VMMC2 is 3.3V.

I've tested with a different combination of parameters in the=20
twl4030_hsmmc_info structure in my board file, and now I'm stuck with=20
the following :

static struct twl4030_hsmmc_info mmc[] =3D {
        {
                .mmc            =3D 1,
                .wires          =3D 4,
                .gpio_wp        =3D -EINVAL,
        },
        {
                .mmc            =3D 2,
                .wires          =3D 4,
                .transceiver    =3D 0,
                .ext_clock      =3D 0,
                .cover_only     =3D 0,
                .gpio_wp        =3D -EINVAL,
                .gpio_cd        =3D -EINVAL,
        },
        {}      /* Terminator */
};

MMC1 works well, but no success for MMC2.

Does someone please have pointers to documentation, apart from the=20
twl4030_hsmmc_info structure header file ?

Thanks in advance.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
