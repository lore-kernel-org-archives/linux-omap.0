From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: Alternative binding proposal for tda998x audio (Was: Re: [PATCH
 RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph of ports)
Date: Tue, 1 Mar 2016 20:26:19 +0100
Message-ID: <20160301202619.011013effd265fdee93d4d8e@free.fr>
References: <cover.1455720381.git.jsarha@ti.com>
	<842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
	<20160218143530.GB9654@rob-hp-laptop>
	<56CF04DA.8080905@ti.com>
	<20160226004311.GM5783@n2100.arm.linux.org.uk>
	<56D02594.4020407@ti.com>
	<20160226112159.GO5783@n2100.arm.linux.org.uk>
	<56D41F1A.2030100@ti.com>
	<56D5A6AA.2030907@ti.com>
	<20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
	<56D5BA6D.8090904@ti.com>
	<20160301171630.630a47dc00060645f89bb8ab@free.fr>
	<56D5DF7D.7090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D5DF7D.7090608-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Mar 2016 20:29:17 +0200
Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:

> I understand the short comings of simple-card and it's binding. Howev=
er,=20
> the binding is documented and it is feasible to extract the audio=20
> connections from a simple-card binding too. In fact it models the I2S=
=20
> connections better than straight out of the box graph binding. Actual=
ly=20
> a graph is not the best way describe an i2s-bus with multiple DAIs=20
> (codec or CPU) connected to it.

I still don't understand your problem. You want something like:

	audio-ports =3D <	TDA998x_SPDIF	0x04
			TDA998x_I2S	0x03>;

and the graph definition would be:

	port@03 {
		reg =3D <0x03>;
		port-type =3D "audio-i2s";
		...
	};

	port@04 {
		reg =3D <0x04>;
		port-type =3D "audio-spdif";
		...
	};

Apart the syntax, I don't really see the difference.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
