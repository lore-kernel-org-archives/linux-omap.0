From: "Chernooky, Vitaly" <vitaly.chernooky@ti.com>
Subject: clock44xx_data.c autogeneration scripts
Date: Thu, 24 Nov 2011 16:16:10 +0200
Message-ID: <CAM2XobxkOrUZkch5An21G5VKzAoDRGpth3hxjmO8LzK6z9aZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54820 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767Ab1KXOQM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 09:16:12 -0500
Received: by mail-qy0-f174.google.com with SMTP id 20so1749405qyd.33
        for <linux-omap@vger.kernel.org>; Thu, 24 Nov 2011 06:16:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

1. Please replace=A0RATE_IN_4430 =3D> RATE_IN_44XX
2. Please replace CK_443X =3D> CK_44XX
3. Please add initialization of field speculate in struct clk:
        .speculate      =3D &omap2_clksel_speculate,
4. Set ops field to &clkops_omap4_dflt_wait instead of
&clkops_omap2_dflt in appropriate places
5. Instead of line:
=2Emax_multiplier =3D 2047,
want:
=2Emax_multiplier =3D OMAP4430_MAX_DPLL_MULT,
6. Instead of line:
=2Emax_divider    =3D 128,
expect:
=2Emax_divider    =3D OMAP4430_MAX_DPLL_DIV,
7.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
