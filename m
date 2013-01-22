From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 10:40:46 +0100
Message-ID: <87ham95zdt.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
	<50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
	<f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
	<20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
	<1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34053 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3AVJkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 04:40:52 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so4226479wgb.13
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 01:40:51 -0800 (PST)
In-Reply-To: <1358846666.3996.3.camel@coredoba.hi.pengutronix.de> ("Jan
	=?utf-8?Q?L=C3=BCbbe=22's?= message of "Tue, 22 Jan 2013 10:24:26 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>
Cc: Paul Walmsley <paul@pwsan.com>, Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "Jan" =3D=3D Jan L=C3=BCbbe <jlu@pengutronix.de> writes:

 Jan> On Tue, 2013-01-22 at 02:24 +0000, Paul Walmsley wrote:
 >> Regarding the AM33xx test failures with appended DTBs, it would be =
very=20
 >> helpful if especially the TI people could try reproducing the probl=
em.
 >> Otherwise it's going to cause problems with merging any new AM33xx=20
 >> patches, since I won't be able to test them without additional work=
=2E =20
 >> Plus, this is something that used to work up until d01e4afd, so som=
ething=20
 >> isn't right.

 Jan> Just a guess, but there can be problems when the appended DTB
 Jan> crosses an 1MB boundary. See this mail for details and a patch:
 Jan> http://www.spinics.net/lists/arm-kernel/msg216898.html

True, but that doesn't seem to be the case here:
ls -la arch/arm/boot/uImage
-rw-r--r-- 1 peko peko 3945127 Jan 22 09:26 arch/arm/boot/uImage

E.G. far from the 1MB boundary.

--=20
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
