From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] Hook start_hnp into ohci struct
Date: Sun, 6 Jul 2008 16:00:11 -0700
Message-ID: <200807061600.11926.david-b@pacbell.net>
References: <20080706102630.GA29934@doriath.ww600.siemens.net> <20080706103050.GB20019@kedavra.cpe.vivax.com.br> <20080706103332.GA28505@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:37617 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753569AbYGFXAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2008 19:00:13 -0400
In-Reply-To: <20080706103332.GA28505@doriath.ww600.siemens.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Sunday 06 July 2008, Dmitry Baryshkov wrote:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ohci->start_hnp =3D start_hnp;
> >=20
> > Why? It's part of struct otg_transceiver.
> >=20
>=20
> Actually the ohci-omap.c:start_hnp does a bit more than just
> otg_start_hnp(tranceiver). Maybe it should be merged. I dunno.

I'm fine with it staying the way it is.  It starts HNP ...
that job is split between several components, and the
transceiver doesn't handle them all.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
