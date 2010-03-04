From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH v2] DSS2: OMAPFB: Add support for switching memory
 regions
Date: Thu, 4 Mar 2010 16:01:59 +0200
Message-ID: <20100304140159.GC18243@nokia.com>
References: <1267555019-18176-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29468 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab0CDOCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 09:02:06 -0500
Content-Disposition: inline
In-Reply-To: <1267555019-18176-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 02, 2010 at 07:36:59PM +0100, Syrjala Ville (Nokia-D/Helsin=
ki) wrote:
> From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
>=20
> Separate the memory region from the framebuffer device a little bit.
> It's now possible to select the memory region used by the framebuffer
> device using the new source_idx parameter of omapfb_plane_info. If th=
e
> source_idx is specified it will be interpreted as an index into the
> memory regions array, if it's not specified the framebuffer's index i=
s
> used instead. So by default each framebuffer keeps using it's own
> memory region which preserves backwards compatibility.
>=20
> This allows cloning the same memory region to several overlays and ye=
t
> each overlay can be controlled independently since they can be
> associated with separate framebuffer devices.
>=20
> Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>

Actaully scrap this one. The use_count thing makes it's somewhat too
easy to get stuck in a state where you can't change the memory size
anymore and going in via sysfs in an effort to fix it doesn't work. I
think I'll just go back to checking all the overlays and expand it to
loop over all the fb devices too. The check won't be entirely accurate
since the fb_infos can't be locked as that could easily lead to ABBA
deadlock with the fb_info lock and the region mutex, but I suppose it's
better than not being able to free/allocate memory anymore.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
