From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Tue, 4 May 2010 16:45:07 +0300
Message-ID: <20100504134507.GJ8310@nokia.com>
References: <hvaibhav@ti.com>
 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
 <1271410679.2690.290.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E1371C6@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E1EB360@dbde02.ent.ti.com>
 <1271848174.2433.49.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E3516FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21557 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0EDNqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 09:46:23 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E3516FE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 04, 2010 at 03:23:10PM +0200, ext Hiremath, Vaibhav wrote:
>=20
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Wednesday, April 21, 2010 4:40 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> >=20
> > On Wed, 2010-04-21 at 12:45 +0200, ext Hiremath, Vaibhav wrote:
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Hiremath, Vaibhav
> > > > Sent: Friday, April 16, 2010 4:28 PM
> > > > To: Tomi Valkeinen
> > > > Cc: linux-omap@vger.kernel.org
> > > > Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > > > Sent: Friday, April 16, 2010 3:08 PM
> > > > > To: Hiremath, Vaibhav
> > > > > Cc: linux-omap@vger.kernel.org
> > > > > Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fix=
ed
> > > > >
> > > > > On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > > > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > > >
> > > > > > In case of 720P with 90/270 degree rotation, the system rep=
orts
> > > > > > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA i=
s not
> > able to
> > > > > fill
> > > > > > the FIFO as per requirement.
> > > > > >
> > > > > > In TRM (section 11.2.6.1.3), where is has been clearly ment=
ioned
> > that,
> > > > > >
> > > > > > "To improve the performance on 90 degree rotation, split th=
e data
> > access
> > > > > on
> > > > > > write side and not read side."
> > > > > >
> > > > > > That means, read should always happen on 0 degree and write=
 should
> > go to
> > > > > > respective rotation view.
> > > > > >
> > > > >
> > > > > With this patch my db test app (from
> > > > > git://gitorious.org/linux-omap-dss2/omapfb-tests.git) shows a=
 lot of
> > > > > tearing when rotation !=3D 0. I tested this on 3430SDP using =
the LCD.
> > > [Hiremath, Vaibhav] Tomi,
> > >
> > > Yes, just now I tried your db application and I am also seeing te=
aring
> > effect. All other apps (including the one which I used for testing)=
 works
> > fine for other rotation angles.
> > >
> > > Let me debug further before commenting anything on this, I just t=
hought of
> > updating you on this.
> >=20
> > "db" app uses double buffering for updating the display, with maxim=
um
> > update rate. There's also "pan" app, that does a bit similar thing =
using
> > fb offsets.
> [Hiremath, Vaibhav] Tomi,
>=20
> I found the bug which is causing tearing effect, I tested it here wit=
h both, mine and your applications and for me it is working fine.
>=20
> Can you please check at your end?
> (Sorry for the attachment)

You should really avoid that. I can't quote the patch.

What are those CW<->CCW swaps that you do in the patch?

Also I think the ioremap stuff is a bit broken since AFAICS it will
leave the old angle still mapped when you rotate to another angle.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
