From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [GIT PULL]: OMAP2/3 Display Subsystem
Date: Fri, 11 Dec 2009 07:49:55 +0200
Message-ID: <1260510595.12346.148.camel@localhost>
References: <1260377610.9700.49.camel@tubuntu.research.nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25866 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbZLKFuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 00:50:44 -0500
In-Reply-To: <1260377610.9700.49.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Wed, 2009-12-09 at 18:53 +0200, Tomi Valkeinen wrote:
> Linus,
>=20
> Here are the new display subsystem and framebuffer drivers for OMAP2/=
3.
>=20
> The drivers have been reviewed on linux-omap and linux-fbdev-devel, a=
nd
> are in use, for example, on N900, Beagle Board and Overo boards.
>=20
> The drivers are actively maintained and developed further, and I have
> already a bunch of patches on top of these patches, but I would like =
to
> get the big core driver merged first. After the core drivers are merg=
ed,
> other people can send patches to LCD drivers and board files to enabl=
e
> the new display subsystem on their boards.
>=20
> Please pull the new OMAP2/3 display subsystem drivers from:
>=20
>   git://gitorious.org/linux-omap-dss2/linux.git for-linus
>=20
>  Tomi

Hi Linus,

I'd like to confirm that DSS2 is used in Nokia both internally and in
production, namely in N900. Other people use it in production as well,
e.g. Gumstix.

DSS2 is basically de-facto standard display sub-system in the OMAP3
world. It is mature, well-written and maintained, being around for at
least 1+ year, and open from almost very beginning.

ACK and Tested-by from my side. The OMAP maintainer (Tony) gave his Ack
as well as many other people, e.g., in this thread:

http://marc.info/?l=3Dlinux-kernel&m=3D125146241831217&w=3D2

DSS2 is in linux-next for some time as well.

Thanks.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
