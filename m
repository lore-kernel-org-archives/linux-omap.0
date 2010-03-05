From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
Date: Fri, 5 Mar 2010 09:28:43 -0600
Message-ID: <A24693684029E5489D1D202277BE894453CC5CD3@dlee02.ent.ti.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
	 <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
	 <A24693684029E5489D1D202277BE894453CC5CA0@dlee02.ent.ti.com>
 <1267802713.25148.146.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33912 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab0CEP2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:28:48 -0500
In-Reply-To: <1267802713.25148.146.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Friday, March 05, 2010 9:25 AM
> To: Aguirre, Sergio
> Cc: Syrjala Ville (Nokia-D/Helsinki); linux-fbdev@vger.kernel.org; li=
nux-
> omap@vger.kernel.org
> Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interru=
pts
>=20
> On Fri, 2010-03-05 at 16:19 +0100, ext Aguirre, Sergio wrote:
> > Hi Ville,
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of ville.syrjala@nokia.com
> > > Sent: Friday, March 05, 2010 7:26 AM
> > > To: Tomi Valkeinen
> > > Cc: linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; Vill=
e
> Syrj=E4l=E4
> > > Subject: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interru=
pts
> > >
> > > From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> > >
> > > When DSS transitions from off mode to on VENC may generate a spur=
ious
> > > SYNC_LOST_DIGIT error. Just ack it when restoring the context. Al=
so
> > > restore IRQENABLE last to avoid triggering interrupts before the
> > > context is fully restored.
> >
> > (Tomi or anyone can correct me if I'm wrong)
> >
> > AFAIK, The solution for spurious interrupts is to flush posted bus
> writes during interrupt handling, which can be achieved by reading th=
e
> same register just after you have written it.
> >
> > Tomi, what do you think?
>=20
> That's a different spurious interrupt =3D).
>=20
> In this case the IRQ mechanism from CPU side is working fine, but VEN=
C
> is just spamming the error interrupts, for unknown reason.

Ohh ok, I see.

Thanks for clarifying. And sorry for the noise.

I'm trying to learn about DSS subsystem, but I'm just a n00b for the mo=
ment :)

Regards,
Sergio
>=20
>  Tomi
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
