From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [RFC/PATCH] NAND bus-width detection extreme makeover
Date: Sat, 30 Nov 2013 13:28:25 -0300
Message-ID: <20131130162824.GA2402@localhost>
References: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131130083537.GB29397@norris.computersforpeace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46319 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751559Ab3K3Q2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Nov 2013 11:28:42 -0500
Content-Disposition: inline
In-Reply-To: <20131130083537.GB29397@norris.computersforpeace.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Pekon Gupta <pekon@ti.com>, shc_work@mail.ru, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, swarren@wwwdotorg.org, rob.herring@calxeda.com, mark.rutland@arm.com, Tony Lindgren <tony@atomide.com>, u.kleine-koenig@pengutronix.de

Hi Brian,

On Sat, Nov 30, 2013 at 12:35:37AM -0800, Brian Norris wrote:
> Hi Ezequiel,
>=20
> On Fri, Nov 29, 2013 at 10:40:55AM -0300, Ezequiel Garcia wrote:
> > Here's my proposal, based in Pekon's latest work.
> >=20
> > This patch removes the flash device bus-width configuration, prior =
to
> > the device detection. With this modification, a NAND driver is no l=
onger
> > able to "force" the device width, and instead can only obtain the d=
etected
> > bus-width after the call to nand_scan_ident().
> >=20
> > Flash devices bus-width are specified either by reading an ONFI fea=
ture,
> > or through a flag in the in-kernel flash devices table. Therefore, =
it doesn't
> > make any sense to somehow "advise" the NAND core about this paramet=
er.
>=20
> Hmm, I think there are a few factors at play here. First of all, the
> hardware driver knows the best about the physical buswidth. It should
> know if there are 8 or 16 data lines connected to the device, so it
> could, for instance, know that it does not have enough data lines to
> support x16 buswidth. (You could possibly devise hardware that can
> support x16 but not x8, I suppose.) So this is one way in which the
> driver must "advise" the NAND core about the buswidth.
>=20
> On the other hand, the hardware/driver doesn't know what buswidth the
> flash chip is. That's nand_base's job. So in that sense, we don't nee=
d
> to "advise" the NAND core.
>=20
> But there are certainly cases where the driver should advise, and if
> there is a mismatch, bail.
>=20

As Pekon just said, the driver can take this action, once the NAND core
has detected the NAND device width and bail out.

I really don't see why we need to *enforce* that in the NAND core.

> > In addition, the ONFI specification requires to issue the detection=
 commands
> > using only the lower 8-bits of the data bus. The ONFI specification=
 says:
> >=20
> >   "" The Read ID and Read Parameter Page commands only use the lowe=
r 8-bits
> >      of the data bus. The host shall not issue commands that use a =
word
> >      data width on x16 devices until the host determines the device=
 supports
> >      a 16-bit data bus width in the parameter page. ""
>=20
> This does not really say that *all* NAND transactions must be perform=
ed
> on the lower 8 bits (a true x8 buswidth), but only that all ONFI
> transactions must be.
>=20

Well, I *think* I never said that, and this patch doesn't imply that
either. All the patch is doing is using x8 buswidth until the width is
detected. Then it switches to whatever the width was detected to.

> > IIRC, the current way of setting the device width is to set NAND_BU=
SWIDTH_AUTO
> > in chip->options and then let the driver set some width-specific ca=
llbacks after
> > the NAND core has detected the width.
> >=20
> > However, as noticed by Pekon Gupta, this means NAND_BUSWIDTH_AUTO s=
hould be
> > always turned on (and hence the option be removed).
>=20
> No, I think you can solve the x16 ONFI detection problem without
> requiring NAND_BUSWIDTH_AUTO.

Uh? I'm not requiring NAND_BUSWIDTH_AUTO at all.

> And in fact, NAND_BUSWIDTH_AUTO only helps
> you wil part of the problem: performing ONFI transactions during the
> initial detection, where you pretend like you're an x8 device.
>=20
> But what happens if a driver needs to use ONFI SET_FEATURES or
> GET_FEATURES after initial probe?
>=20
> So I think the problem may need to be divided into 2 parts:
>=20
>  1) How do we best handle ONFI transactions, so that they are always
>     performed on the lower 8 bits of the bus **regardless of actual
>     buswidth**? (I think Uwe's patch + my response in [1] might solve
>     this.)
>=20
>  2) Can/should we relax the old restrictions where drivers have to
>     configure the buswidth correctly before running nand_scan_ident()=
,
>     in the spirit of NAND_BUSWIDTH_AUTO? And why do we need this
>     flexibility?
>=20

Uh? Both (1) and (2) are already handled by this patch, regarding the
initial device detection.

[..]
> > Of course, the memory controller (such as GPMC in the OMAP case) st=
ill needs
> > proper width a-prior configuration, but that's completely unrelated=
 to the
> > flash device bus width.
>=20
> I would disagree.
>=20

On which arguments?

To be honest with you, I'm a bit lost about your feedback :-)

I guess you *did* read the patch, right? It's pretty straight-forward
and it fixes a *current* bug: 16-bit devices *cannot* be ONFI
detected.

All the patch does is:

1. Set defaults to x8

2. Detect device. Either method works.

3. Set defaults to detected width, x8 or x16.

The NAND driver is free, after the detection, to error-out, print a
message, or re-arrange the callbacks.

Which part exactly of the above do you disagree with?

Now, maybe I went to far talking about removing this or that, but as fa=
r
as the ONFI detection, I think the change is pretty-straightforward.

(I'll reply to your suggestion in the proper mail)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
