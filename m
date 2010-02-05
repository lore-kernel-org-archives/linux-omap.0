From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: OMAPFB: implement
 OMAPFB_GET_DISPLAY_INFO
Date: Fri, 05 Feb 2010 11:28:18 +0200
Message-ID: <1265362098.17836.169.camel@tubuntu.research.nokia.com>
References: <1265297486-22438-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1265297486-22438-2-git-send-email-tomi.valkeinen@nokia.com>
	 <20100204230512.GA10145@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39943 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab0BEJZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 04:25:57 -0500
In-Reply-To: <20100204230512.GA10145@sci.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2010-02-05 at 00:05 +0100, ext Ville Syrj=C3=A4l=C3=A4 wrote:
> On Thu, Feb 04, 2010 at 05:31:26PM +0200, Tomi Valkeinen wrote:
> > Previously the only place to get the size of the display was from t=
he
> > DSS's sysfs interface, making, for example, configuring overlays an=
d doing
> > updates on manual displays more difficult.
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > ---
> >  drivers/video/omap2/omapfb/omapfb-ioctl.c |   18 +++++++++++++++++=
+
> >  include/linux/omapfb.h                    |    7 +++++++
> >  2 files changed, 25 insertions(+), 0 deletions(-)
> >=20
> <snip>
> > @@ -216,6 +217,12 @@ struct omapfb_tearsync_info {
> >  	__u16 reserved2;
> >  };
> > =20
> > +struct omapfb_display_info {
> > +	__u16 width;
> > +	__u16 height;
>=20
> How about adding the physical display size here as well? I suppose
> mm is the standard unit for such things but for small displays more
> accuracy might be nice.

That can be read from framebuffer's var struct. But I could add it here
also for completeness. Perhaps also some other display related info,
like capabilities.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
