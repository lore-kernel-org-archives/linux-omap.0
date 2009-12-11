From: Juha Leppanen <juha_motorsportcom@luukku.com>
Subject: OMAP: DSS2: fix timeout
Date: Fri, 11 Dec 2009 13:46:52 +0200 (EET)
Message-ID: <1260532012356.juha_motorsportcom.43554.MJrAsHh1bjkDfuhyBubUGg@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-out-1.luukku.com ([194.111.136.57]:45902 "EHLO
	mta-out-1.luukku.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901AbZLKMIk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 07:08:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

Hi,

checking some patches thru www.kernel.org

/drivers/video/omap2/dss/dss.c

I noticed that if timeout happens,
REG_GET is not checked after last 1000th udelay.
Why not check it?

static int _omap_dss_wait_reset(void)
{
-	unsigned timeout =3D 1000;
+	int timeout =3D 1000;

	while (REG_GET(DSS_SYSSTATUS, 0, 0) =3D=3D 0) {
-		udelay(1);
-		if (!--timeout) {
+		if (--timeout < 0) {
			DSSERR("soft reset failed\n");
			return -ENODEV;
		}
+		udelay(1);
	}

	return 0;
}


Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
Signed-off-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>

No reply needed to me,
my spam filter will probably eat your reply.

Happy hacking,

Mr. Juha Leppanen
Kuopio, Finland


=2E...................................................................
Luukku Plus -paketilla p=E4=E4set eroon tila- ja turvallisuusongelmista=
=2E
Hanki Luukku Plus ja helpotat el=E4m=E4=E4si. http://www.mtv3.fi/luukku
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
