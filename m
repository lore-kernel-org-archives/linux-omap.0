From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Thu, 14 Aug 2008 10:55:09 +0530
Message-ID: <000001c8fdce$1f8d1890$LocalHost@wipultra1382>
References: <13B9B4C6EF24D648824FF11BE896716203620A5686@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:48948 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbYHNFZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 01:25:25 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203620A5686@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, =?utf-8?Q?'H=C3=B6gander_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org


> -----Original Message-----
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
> Sent: Wednesday, August 13, 2008 6:06 PM
> To: H=C3=B6gander Jouni; Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
>=20
> > >> Doing this would make serial console to work faster.
> > >
> > > Yes, I removed these in my patches and put in the changes=20
> suggested=20
> > > by
> > Richard
> > > in 8250.c
> >
> > I doubt that your changes to 8250.c will be applied. I have=20
> understood=20
> > that omap specific changes are not accepted to generic 8250 driver.=
=20
> > Anyway these changes doesn't help too much. Serial console is=20
> > annoyingly slow if sleep while idle is enabled.
>=20
> Rajendra is it slow in your current builds on this tree with=20
> fixes in place?  Sluggish serial has NOT been an issue for us=20
> in other trees for a long time.  Perhaps something is missing.

Yes, its indeed a bit sluggish in my builds as well. Not as good as wha=
t we
have in our internal tree.=20

>=20
> In general keeping code out of the C0 path is good.  What=20
> ever method makes console serial usable and gets out of the=20
> way fastest to get better power measurements in typical test=20
> environment is good.
>=20
> Is the comment on the smart idle / no idle aspect or the whole path?
>=20
> It probably is easier to put changes in our local cpu_idle-C0=20
> function as compared to a shared 8250 driver.  But if it=20
> means adding extra code on a hot system path it is less appealing.
>=20
> If it's working here, we can ask what opinions are on=20
> ARM-Linux list. Today there are other UART instance specific=20
> work arounds in that code.
>=20
> Regards,
> Richard W.
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
