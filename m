From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Wed, 19 May 2010 18:39:50 +0300
Message-ID: <20100519153950.GK30960@nokia.com>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
 <1274257308.2307.168.camel@tubuntu.research.nokia.com>
 <20100519142732.GG30960@nokia.com>
 <20100519150057.GA16082@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100519150057.GA16082@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 19, 2010 at 05:00:58PM +0200, ext Paul Mundt wrote:
> On Wed, May 19, 2010 at 05:27:32PM +0300, Ville Syrj?l? wrote:
> > On Wed, May 19, 2010 at 10:21:48AM +0200, Valkeinen Tomi (Nokia-D/H=
elsinki) wrote:
> > > I think a simple solution would be to just use defines, and have
> > > functions that take the command as u8. That's what the OMAP DSI d=
river
> > > does. If you have better ideas, please share =3D).
> >=20
> > I find enums easier on the eye than defines. Less irrelevant junk o=
n
> > each line. There's no reason you can't pass enum values as u8. But =
in
> > that case giving the enum a name doesn't really make sense.
> >=20
> enums are cleaner for these cases, but you also have the case where t=
he
> enum type itself is variable size depending on the ABI being used. If
> the type in question isn't being packed in to a user-visible data
> structure then this will never matter, but it does help to be a bit
> careful here regardless. Many people were bitten by this in the ARM
> OABI -> EABI conversion, while other architectures generally managed =
to
> get it right from the onset.

Yeah using the enum type in ABI is a bad idea since actual type is
implementation defined. But if you don't give the enum an identifier
there's no way to even accidentally use it as a type.

--=20
Ville Syrj=E4l=E4
