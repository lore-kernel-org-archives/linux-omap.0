From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 5/6] leds: lp5521: move to drivers/leds
Date: Sat, 14 Feb 2009 00:36:37 +0200
Message-ID: <20090213223636.GP10711@frodo>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com> <1234529032-25354-5-git-send-email-felipe.balbi@nokia.com> <1234529032-25354-6-git-send-email-felipe.balbi@nokia.com> <200902131249.00592.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57447 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbZBMWgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 17:36:44 -0500
Content-Disposition: inline
In-Reply-To: <200902131249.00592.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Feb 13, 2009 at 12:49:00PM -0800, David Brownell wrote:
> On Friday 13 February 2009, Felipe Balbi wrote:
> > +=A0=A0=A0=A0=A0=A0=A0if (!strncmp(buf, "run", 3))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip,=
 LP5521_MODE_RUN);
> > +=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(buf, "load", 4))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip,=
 LP5521_MODE_LOAD);
> > +=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(buf, "direct", 6))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip,=
 LP5521_MODE_DIRECT_CONTROL);
>=20
> Minor nit, which could be addressed by a followon patch:
> This is an ideal use-case for using sysfs_streq().
>=20
> And there's no terminal "else len =3D -EINVAL" to handle the
> case of illegal modes...

Ok, here's an *untested* patch solving issues.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom 0872878daaa4a1768a3f56995ec416941758be6b Mon Sep 17 00:00:00 200=
1
=46rom: Felipe Balbi <felipe.balbi@nokia.com>
Date: Sat, 14 Feb 2009 00:34:56 +0200
Subject: [PATCH] leds: lp5521: use sysfs_streq()

instead of using strcmp() for comparing strings,
use sysfs_streq().

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/leds/leds-lp5521.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index b3ba52a..3e1ca31 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -352,12 +352,14 @@ static ssize_t store_mode(struct device *dev,
=20
 	mutex_lock(&chip->lock);
=20
-	if (!strncmp(buf, "run", 3))
+	if (sysfs_streq(buf, "run"))
 		lp5521_set_mode(chip, LP5521_MODE_RUN);
-	else if (!strncmp(buf, "load", 4))
+	else if (sysfs_streq(buf, "load"))
 		lp5521_set_mode(chip, LP5521_MODE_LOAD);
-	else if (!strncmp(buf, "direct", 6))
+	else if (sysfs_streq(buf, "direct"))
 		lp5521_set_mode(chip, LP5521_MODE_DIRECT_CONTROL);
+	else
+		len =3D -EINVAL;
=20
 	mutex_unlock(&chip->lock);
=20
--=20
1.6.2.rc0.61.g5cd12


--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
