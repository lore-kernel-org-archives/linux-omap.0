From: =?iso-8859-1?Q?Syrj=E4l=E4_Ville_=28Nokia-D=2FHelsinki=29?=
	<ville.syrjala@nokia.com>
Subject: Re: [PATCH 1/3] OMAPFB: install omapfb.h
Date: Tue, 2 Mar 2010 18:16:31 +0200
Message-ID: <20100302161631.GK18322@nokia.com>
References: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
 <1267442684.2406.11.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47400 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab0CBQR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 11:17:57 -0500
Content-Disposition: inline
In-Reply-To: <1267442684.2406.11.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 01, 2010 at 12:24:44PM +0100, Valkeinen Tomi (Nokia-D/Helsi=
nki) wrote:
> Hi,
>=20
> On Tue, 2010-02-23 at 23:36 +0100, Syrjala Ville (Nokia-D/Helsinki)
> wrote:
> > From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> >=20
> > omapfb has several custom ioctls so user space needs
> > the header in order to utilize them.
> >=20
> > Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
>=20
> This one, and the 2/3 patch look fine, I'll apply them.
>=20
> The third one does not apply to my current DSS2 tree, so it needs som=
e
> updating.

Hmm, OK. Do you want it against master or some other branch? IIRC
that's what I used.

I just hit a few bugs in this patch as well so I will send a v2 soon.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
