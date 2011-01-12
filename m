From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issues with ADATA SD cards on OMAP?
Date: Wed, 12 Jan 2011 09:48:14 -0800
Message-ID: <AANLkTimo_7zK0WT81jJ1F2iat+9G0aC0O=4pJPt6O4J2@mail.gmail.com>
References: <AANLkTinw=ZjiOr1KHNxu1Npq5iLucOPyw0Gumdyq1jjS@mail.gmail.com>
	<AANLkTi=SKb9wCUMyvvT59qYCMm8wViZRAYgtDOJXiLKy@mail.gmail.com>
	<B00BD5DB-31BB-42C8-B360-241173342F86@mac.com>
	<AANLkTik8wTknohEDfNnoYsZt8xuQRb48gUC7T_Xg+afz@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036A6F2808@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58026 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab1ALRsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 12:48:15 -0500
Received: by qyj19 with SMTP id 19so4436693qyj.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 09:48:15 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A6F2808@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Elvis Dowson <elvis.dowson@mac.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tue, Jan 11, 2011 at 10:17 PM, Ghorai, Sukumar <s-ghorai@ti.com> wro=
te:

> [Ghorai]
> We also experienced the same issue using 32GB SD card for omap3 and o=
map4.
> And the problem is seen is that DTO value (in SYSCTL) is not current
> in following function.
>
> So add the following modification and please update the status.
> And we will submit proper patch towards the same.
>
> static void set_data_timeout(..){
> ...
> =A0 =A0 =A0cycle_ns =3D 1000000000 / (clk_get_rate(host->fclk) / clkd=
);
> =A0 =A0 =A0 =A0timeout =3D timeout_ns / cycle_ns;
> =A0 =A0 =A0 =A0timeout +=3D timeout_clks;
> + timeout *=3D2;
> =A0 =A0 =A0if (timeout) {
> ...
> }

I tried this change.  While it seemed to improve things a bit for the
ADATA card I tested, I was still not able to boot successfully.

I will investigate further.  Forcing a value of 14 makes the card
work.  I'll add a printk to see what dto value is computed by your
patch.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
