From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Issue : jffs2 and ecc layout
Date: Thu, 23 Dec 2010 16:24:35 +0800
Message-ID: <AANLkTimJFsjLT15FA+TqDKzjvPXgxUAvovWpWKP3NCK4@mail.gmail.com>
References: <ActfCy0cZc3bW9yIT5u5fx8oZO9GQw==>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52970 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab0LWIYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 03:24:35 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so5829513wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 00:24:35 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

2010/9/28 Ghorai, Sukumar <s-ghorai@ti.com>:
> Hi,
> I was using the following ecc layout which is not working to mount th=
e jffs2 File-system. I was in 2.6.32 kernel and working; but same layou=
t is not working with latest 2.6 kernel.
>
> Observation is that - no read request issued to the driver (say omap2=
=2Ec).
>
> # mount -t jffs2 /dev/mtdblock4 /mnt/nand
> [=A0=A0 32.505218] cannot read OOB for EB at 00000000, requested 8 by=
tes, read 0 bytes, error -22
> mount: Mounting /dev/mtdblock4 on /mnt/nand failed: Input/output erro=
r

I meet the issue too, kernel is  2.6.37-rc6-next-20101217+, and board i=
s
beagle B5.

Is there any way to fix or workaround the issue?


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
