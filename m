From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAPFB: install omapfb.h
Date: Mon, 01 Mar 2010 13:24:44 +0200
Message-ID: <1267442684.2406.11.camel@tubuntu.research.nokia.com>
References: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39016 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0CALZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 06:25:10 -0500
In-Reply-To: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-02-23 at 23:36 +0100, Syrjala Ville (Nokia-D/Helsinki)
wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
>=20
> omapfb has several custom ioctls so user space needs
> the header in order to utilize them.
>=20
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

This one, and the 2/3 patch look fine, I'll apply them.

The third one does not apply to my current DSS2 tree, so it needs some
updating.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
