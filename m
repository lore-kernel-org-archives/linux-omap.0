From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Test: please ignore
Date: Mon, 23 Apr 2012 02:43:45 +0300
Message-ID: <4f94958852a74_1447a5ede449e4@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60040 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908Ab2DVXtF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Apr 2012 19:49:05 -0400
Received: by lahj13 with SMTP id j13so8706003lah.19
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 16:49:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Greg KH wrote:
> On Sun, Apr 22, 2012 at 10:57:17AM +0100, Russell King - ARM Linux wr=
ote:
> > I've noticed these failure from time to time in my omap4 randconfig=
 builds:
> >=20
> > drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_=
brd_start':
> > drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit =
declaration of function 'OMAP2_L4_IO_ADDRESS'
> > drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
> > drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declarat=
ion of function 'OMAP2_L4_IO_ADDRESS'
> >=20
> > Looking at git, it looks like there is some activity with tidspbrid=
ge
> > (by V=C3=ADctor).  Is there any interest in fixing these errors for=
 v3.4
> > (or even v3.4-rc5)?
>=20
> Along those lines, what's the plans on getting this code _out_ of
> staging?  I haven't seen anything going on here in a while...

Test 6.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
