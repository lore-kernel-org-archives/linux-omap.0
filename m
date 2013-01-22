From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 09:52:18 +0000
Message-ID: <20130122095218.GD2637@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com> <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna> <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com> <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk> <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com> <1358846666.3996.3.camel@coredoba.hi.pengutronix.de> <87ham95zdt.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52161 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab3AVJwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 04:52:46 -0500
Content-Disposition: inline
In-Reply-To: <87ham95zdt.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, "Menon, Nishanth" <nm@ti.com>, Matt Porter <mporter@ti.com>, Paul Walmsley <paul@pwsan.com>, Richard Cochran <richardcochran@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 22, 2013 at 10:40:46AM +0100, Peter Korsgaard wrote:
> >>>>> "Jan" =3D=3D Jan L=FCbbe <jlu@pengutronix.de> writes:
>=20
>  Jan> On Tue, 2013-01-22 at 02:24 +0000, Paul Walmsley wrote:
>  >> Regarding the AM33xx test failures with appended DTBs, it would b=
e very=20
>  >> helpful if especially the TI people could try reproducing the pro=
blem.
>  >> Otherwise it's going to cause problems with merging any new AM33x=
x=20
>  >> patches, since I won't be able to test them without additional wo=
rk. =20
>  >> Plus, this is something that used to work up until d01e4afd, so s=
omething=20
>  >> isn't right.
>=20
>  Jan> Just a guess, but there can be problems when the appended DTB
>  Jan> crosses an 1MB boundary. See this mail for details and a patch:
>  Jan> http://www.spinics.net/lists/arm-kernel/msg216898.html
>=20
> True, but that doesn't seem to be the case here:
> ls -la arch/arm/boot/uImage
> -rw-r--r-- 1 peko peko 3945127 Jan 22 09:26 arch/arm/boot/uImage
>=20
> E.G. far from the 1MB boundary.

Don't rely on that.  Remember, if the compressed image occupies the sam=
e
location as the decompressed kernel, the decompressor will copy the dat=
a
to a different location in RAM first - I think at RAM offset + 32K +
decompressed kernel size.

So yes, please try the patch in the link above.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
