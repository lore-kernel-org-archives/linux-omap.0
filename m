From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAPFB: install omapfb.h
Date: Tue, 02 Mar 2010 18:20:09 +0200
Message-ID: <1267546809.2406.69.camel@tubuntu.research.nokia.com>
References: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
	 <1267442684.2406.11.camel@tubuntu.research.nokia.com>
	 <20100302161631.GK18322@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47490 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab0CBQUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 11:20:22 -0500
In-Reply-To: <20100302161631.GK18322@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-03-02 at 17:16 +0100, Syrjala Ville (Nokia-D/Helsinki)
wrote:
> On Mon, Mar 01, 2010 at 12:24:44PM +0100, Valkeinen Tomi (Nokia-D/Hel=
sinki) wrote:
> > Hi,
> >=20
> > On Tue, 2010-02-23 at 23:36 +0100, Syrjala Ville (Nokia-D/Helsinki)
> > wrote:
> > > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
> > >=20
> > > omapfb has several custom ioctls so user space needs
> > > the header in order to utilize them.
> > >=20
> > > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
> >=20
> > This one, and the 2/3 patch look fine, I'll apply them.
> >=20
> > The third one does not apply to my current DSS2 tree, so it needs s=
ome
> > updating.
>=20
> Hmm, OK. Do you want it against master or some other branch? IIRC
> that's what I used.
>=20
> I just hit a few bugs in this patch as well so I will send a v2 soon.

Ok. You can use git://gitorious.org/linux-omap-dss2/linux.git for-next
branch, that contains the latest "official" stuff.

 Tomi



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
