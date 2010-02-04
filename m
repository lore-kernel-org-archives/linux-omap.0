From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 2/2] OMAP: DSS2: OMAPFB: implement
 OMAPFB_GET_DISPLAY_INFO
Date: Fri, 5 Feb 2010 01:05:12 +0200
Message-ID: <20100204230512.GA10145@sci.fi>
References: <1265297486-22438-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265297486-22438-2-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:43931 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758475Ab0BDXWr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 18:22:47 -0500
Content-Disposition: inline
In-Reply-To: <1265297486-22438-2-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Feb 04, 2010 at 05:31:26PM +0200, Tomi Valkeinen wrote:
> Previously the only place to get the size of the display was from the
> DSS's sysfs interface, making, for example, configuring overlays and =
doing
> updates on manual displays more difficult.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |   18 ++++++++++++++++++
>  include/linux/omapfb.h                    |    7 +++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
>=20
<snip>
> @@ -216,6 +217,12 @@ struct omapfb_tearsync_info {
>  	__u16 reserved2;
>  };
> =20
> +struct omapfb_display_info {
> +	__u16 width;
> +	__u16 height;

How about adding the physical display size here as well? I suppose
mm is the standard unit for such things but for small displays more
accuracy might be nice.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
