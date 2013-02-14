From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [RFC 1/1] ARM: omap2: gpmc: Move binding documentation to
 memory-controller
Date: Thu, 14 Feb 2013 07:20:37 -0300
Message-ID: <20130214102036.GB2429@localhost>
References: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360754003-3988-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <511BAD97.5050602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54312 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab3BNKU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 05:20:56 -0500
Content-Disposition: inline
In-Reply-To: <511BAD97.5050602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, zonque@gmail.com

On Wed, Feb 13, 2013 at 09:13:27AM -0600, Jon Hunter wrote:
>=20
> On 02/13/2013 05:13 AM, Ezequiel Garcia wrote:
> > GPMC stands for General Purpose Memory Controller, and it's primari=
ly
> > used to handle memories such as NOR, NAND, SRAM.
> > Note that this controller is also used to handle network controller=
s
> > such as smsc911x.
> >=20
> > This patch moves the documentation binding to memory-controllers,
> > where it belongs.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  .../ti-gpmc.txt =3D> memory-controllers/ti/gpmc.txt} |    0
> >  1 files changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt =3D> mem=
ory-controllers/ti/gpmc.txt} (100%)
> >=20
> > diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Do=
cumentation/devicetree/bindings/memory-controllers/ti/gpmc.txt
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/bus/ti-gpmc.txt
> > rename to Documentation/devicetree/bindings/memory-controllers/ti/g=
pmc.txt
>=20
> I am fine with that. However, make sure you CC the device-tree mailin=
g list.
>=20

Sorry about that. I also forgot to put Daniel Mack in CC, who added thi=
s
document in the first place.

@Daniel: what do you think?

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
