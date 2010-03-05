From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
Date: Fri, 05 Mar 2010 17:25:13 +0200
Message-ID: <1267802713.25148.146.camel@tubuntu.research.nokia.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
	 <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
	 <A24693684029E5489D1D202277BE894453CC5CA0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28018 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab0CEPZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:25:37 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894453CC5CA0@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre, Sergio" <saaguirre@ti.com>
Cc: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2010-03-05 at 16:19 +0100, ext Aguirre, Sergio wrote:
> Hi Ville,
>=20
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of ville.syrjala@nokia.com
> > Sent: Friday, March 05, 2010 7:26 AM
> > To: Tomi Valkeinen
> > Cc: linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; Ville =
Syrj=C3=A4l=C3=A4
> > Subject: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupt=
s
> >=20
> > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
> >=20
> > When DSS transitions from off mode to on VENC may generate a spurio=
us
> > SYNC_LOST_DIGIT error. Just ack it when restoring the context. Also
> > restore IRQENABLE last to avoid triggering interrupts before the
> > context is fully restored.
>=20
> (Tomi or anyone can correct me if I'm wrong)
>=20
> AFAIK, The solution for spurious interrupts is to flush posted bus wr=
ites during interrupt handling, which can be achieved by reading the sa=
me register just after you have written it.
>=20
> Tomi, what do you think?

That's a different spurious interrupt =3D).

In this case the IRQ mechanism from CPU side is working fine, but VENC
is just spamming the error interrupts, for unknown reason.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
