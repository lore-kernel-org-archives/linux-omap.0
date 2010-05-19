From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Wed, 19 May 2010 17:27:32 +0300
Message-ID: <20100519142732.GG30960@nokia.com>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
 <1274257308.2307.168.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274257308.2307.168.camel@tubuntu.research.nokia.com>
Sender: linux-sh-owner@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 19, 2010 at 10:21:48AM +0200, Valkeinen Tomi (Nokia-D/Helsi=
nki) wrote:
> Hi,
>=20
> On Wed, 2010-05-19 at 10:08 +0200, ext Guennadi Liakhovetski wrote:
> > Hi Tomi
> >=20
> > On Wed, 19 May 2010, Tomi Valkeinen wrote:
> > > > +	MIPI_DSI_DCS_SHORT_WRITE			=3D 5,
> > >=20
> > > Please use the same number format for all enums. So this should b=
e 0x05.
> >=20
> > Where does this requirement come from? Is it in CodingStyle?;)
>=20
> I don't know, but mixing different formats looks ugly to me =3D).

One case where it would perhaps make sense if you define some fields
with shifts and masks. Specifying shifts as decimal and masks as hex
is clearer IMO. But in this case I agree it just looks ugly and only
serves to confuse the reader as he tries to figure out if there's
some magic meaning to the different formats.

>=20
> > > > +	MIPI_DSI_DCS_SHORT_WRITE_PARAM			=3D 0x15,
> > > > +	MIPI_DSI_COLOR_MODE_OFF				=3D 2,
> > > > +	MIPI_DSI_COLOR_MODE_ON				=3D 0x12,
> > > > +	MIPI_DSI_SHUTDOWN_PERIPHERAL			=3D 0x22,
> > > > +	MIPI_DSI_TURN_ON_PERIPHERAL			=3D 0x32,
> > > > +	MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM		=3D 3,
> > > > +	MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM		=3D 0x13,
> > > > +	MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM		=3D 0x23,
> > > > +	MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM		=3D 4,
> > > > +	MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM		=3D 0x14,
> > > > +	MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM		=3D 0x24,
> > > > +	MIPI_DSI_DCS_LONG_WRITE				=3D 0x39,
> > > > +	MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE		=3D 0x37,
> > > > +	MIPI_DSI_NULL_PACKET				=3D 9,
> > > > +	MIPI_DSI_BLANKING_PACKET			=3D 0x19,
> > > > +	MIPI_DSI_GENERIC_LONG_WRITE			=3D 0x29,
> > > > +	MIPI_DSI_LOOSELY_PACKED_PIXEL_STREAM_YCBCR20	=3D 0xc,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR24		=3D 0x1c,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16		=3D 0x2c,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_30			=3D 0xd,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_36			=3D 0x1d,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12		=3D 0x3d,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_16			=3D 0xe,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_18			=3D 0x1e,
> > > > +	MIPI_DSI_PIXEL_STREAM_3BYTE_18			=3D 0x2e,
> > > > +	MIPI_DSI_PACKED_PIXEL_STREAM_24			=3D 0x3e,
> > > > +};
> > > > +
> > > > +enum mipi_dcs_cmd {
> > >=20
> > > While the MIPI specs define a certain set of commands, the real p=
anels
> > > usually implement also their own custom commands. That's why I do=
n't
> > > think enum is a good choice here.
> >=20
> > Yes, that's a valid point, I'll have to think about it more.
>=20
> I think a simple solution would be to just use defines, and have
> functions that take the command as u8. That's what the OMAP DSI drive=
r
> does. If you have better ideas, please share =3D).

I find enums easier on the eye than defines. Less irrelevant junk on
each line. There's no reason you can't pass enum values as u8. But in
that case giving the enum a name doesn't really make sense.

--=20
Ville Syrj=E4l=E4
