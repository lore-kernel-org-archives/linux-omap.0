From: Daniel Toussaint <daniel@dmhome.net>
Subject: Re: [PATCH 1/2 (for-next)] ARM: OMAP3: Add support for the IGEP v2
 board (rev B)
Date: Sun, 15 Nov 2009 01:13:22 +0800
Message-ID: <4AFEE532.2060407@dmhome.net>
References: <4AFD8DBA.6040906@sios.fr>
Reply-To: daniel@dmhome.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54158 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbZKNRNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 12:13:24 -0500
Received: by ywh40 with SMTP id 40so2109364ywh.33
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 09:13:30 -0800 (PST)
In-Reply-To: <4AFD8DBA.6040906@sios.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_BEGOU?= <fbegou@sios.fr>
Cc: linux-omap@vger.kernel.org

=46r=E9d=E9ric BEGOU wrote:
> Hello,
>
> For what I've seen on the Internet concerning your card, there is onl=
y=20
> one MMC card reader.
> Besides, there is the following piece of code :
>
>> +static struct twl4030_hsmmc_info mmc[] =3D {
>> +       {
>> +               .mmc            =3D 1,
>> +               .wires          =3D 4,
>> +               .gpio_cd        =3D -EINVAL,
>> +               .gpio_wp        =3D -EINVAL,
>> +       },
>> +       {
>> +               .mmc            =3D 2,
>> +               .wires          =3D 4,
>> +               .gpio_cd        =3D -EINVAL,
>> +               .gpio_wp        =3D -EINVAL,
>> +       },
>> +       {}      /* Terminator */
>> +};
>
> Maybe I am mistaken, but doesn't that mean there are two MMC cards ?
>
> I am interested in the subject, as I am trying to write my own board=20
> file for our custom, beagleboard-based card, with no success so far=20
> concerning the second MMC reader...

Well, it seems that the board is question has a WIFI module connected t=
o=20
the second mmc. What is your problem right now ? Remember that all thre=
e=20
MMC slots are different  in what kind of voltage they can drive.




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
