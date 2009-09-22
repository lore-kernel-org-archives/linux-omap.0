From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: Bad block on N810
Date: Tue, 22 Sep 2009 11:16:20 +0400
Message-ID: <73aaf0dd0909220016p56a1c921g9bee92656478e872@mail.gmail.com>
References: <4AB245B3.10909@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:40093 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbZIVHYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 03:24:15 -0400
Received: by ewy7 with SMTP id 7so138836ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 00:24:18 -0700 (PDT)
In-Reply-To: <4AB245B3.10909@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

> Hi folks,
>
> I'm having a curious problem with my N810: my device turn off (turn o=
ff, not restart) always a few seconds after just initialized.
>
> Well, after taking a look in dbug mode, I saw the the following probl=
ems:
>
> [ =A0 36.921875] JFFS2 notice: (1200) check_node_data: wrong data CRC=
 in data node at 0x0b651edc: read 0x25e088e1, calculated 0x76861b05.
> ...
> [ =A0 40.578125] JFFS2 warning: (1293) jffs2_sum_write_sumnode: Not e=
nough space for summary, padsize =3D -965
>
> I already reflash the FIASCO image, but this error persists. So it lo=
oks that the fs has some problem (bad block) on internal memory card. m=
kfs could solve the problem, but, as I mentioned above, only a few seco=
nds after starting, the device shutdown =A0:(
>
> Any hints?

Hello.

AFAIK N810 is turned off by its watchdog, so be sure to touch it at
least once a minute, like this:

echo 63 > /sys/devices/platform/retu-watchdog/period

--=20
Max
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
