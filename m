From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: RE: [RFC PATCH 0/5] HSI framework and drivers
Date: Mon, 26 Apr 2010 12:32:20 +0300
Message-ID: <1272274340.17338.83.camel@localhost>
References: <1272035728-6933-1-git-send-email-carlos.chinea@nokia.com>
	 <alpine.DEB.2.00.1004231001190.29720@utopia.booyaka.com>
	 <725063E4C37388418CDDC5A2C287906A16B778D24E@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41784 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab0DZJ3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 05:29:24 -0400
In-Reply-To: <725063E4C37388418CDDC5A2C287906A16B778D24E@NOK-EUMSG-03.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Vehmanen Kai (Nokia-D/Tampere)" <Kai.Vehmanen@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "s-jan@ti.com" <s-jan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2010-04-23 at 21:44 +0200, Vehmanen Kai (Nokia-D/Tampere) wrote=
:
> Hi Paul and others,
>=20
> On 23 April 2010, Paul Walmsley wrote:
> >> SSI, which is a legacy version of HSI, is used to connect the appl=
ication
> >> engine with the cellular modem on the Nokia N900.
> >>
> >> This patch set is based on 2.6.34-rc3
> >
> >Have you looked at S=C3=A9bastien's HSI driver code:
> >
> >http://www.mail-archive.com/linux-omap@vger.kernel.org/msg18506.html
>=20
> I think the history of the patches is already shared. I've been=20
> looking at this from the sidelines and I think the story so=20
> far is:
>=20
> 2008: Carlos sent the original SSI patchset (and got comments)
>    -> http://lkml.org/lkml/2008/10/3/116
> 2009: S=C3=A9bastien sent an updated patchset (and got comments)
>    -> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg18506=
=2Ehtml
>=20
> .. and now this latest one from Carlos is a completely new
> design that attempts to address the design comments that have
> been raised, hopefully pushing HSI/SSI a step closer to=20
> getting accepted. I'll leave it to Carlos and S=C3=A9bastien to=20
> correct me if I got the above wrong...

Yep you got it right. S=C3=A9bastien and I have been also in contact ab=
out
the new API and he has already given some feedback on an initial versio=
n
of the framework.

Br,
Carlos

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
