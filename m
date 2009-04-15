From: Tim Yamin <plasm@roo.me.uk>
Subject: Re: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
	Valkeinen, I have some questions about dss2 driver.]
Date: Wed, 15 Apr 2009 12:16:53 -0700
Message-ID: <792f5f410904151216j263eec47n5047c25442083420@mail.gmail.com>
References: <792f5f410904131400v3199fa09w14c24f01f468d1c2@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A208D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:39725 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbZDOTQz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 15:16:55 -0400
Received: by rv-out-0506.google.com with SMTP id f9so48136rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 12:16:53 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A208D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shah, Hardik" <hardik.shah@ti.com>
Cc: "gregoire@gentil.com" <gregoire@gentil.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Hi Hardik,

2009/4/15 Shah, Hardik <hardik.shah@ti.com>:
> [Shah, Hardik] Hi Tim,
> Try to increase the pixel clock to functional clock ratio to 6 or 8. =
=A0This may help as you are getting under run errors.

Thanks for the help -- so it seems that it's a clock issue. At 800x600
rotation of both planes simultaneously by 90 degrees is working just
fine. At 1024x768 it seems that it's not possible because of the
clocking: the pixel clock is 56MHz so the maximum
OMAP2_DSS_MIN_FCK_PER_PCK constant is 3, which does not seem to be
sufficient.

Cheers,

Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
