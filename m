From: Pierre Beaumon <pierre.beaumon@yahoo.com>
Subject: Re : Arm device tree wonder
Date: Mon, 5 Sep 2011 23:04:20 +0100 (BST)
Message-ID: <1315260260.18862.YahooMailNeo@web132209.mail.ird.yahoo.com>
References: <1314734987.11994.YahooMailNeo@web132211.mail.ird.yahoo.com> <alpine.DEB.2.00.1108301910390.26173@utopia.booyaka.com>
Reply-To: Pierre Beaumon <pierre.beaumon@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm12.bullet.mail.ird.yahoo.com ([77.238.189.65]:44221 "HELO
	nm12.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751072Ab1IEWEX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Sep 2011 18:04:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Paul,

thanks for your reply.

> On Tue, 30 Aug 2011, Pierre Beaumon wrote:
>=A0
> > Also I believe one big arm problem is a lack of common
> > infrastructure that lead to code duplication. Some machine try to
> > do too much things. omap2 (mach-omap2 + plat-omap) is about 80
> > KSLOC over 400KSLOC (76 mach=A0
> > + plat directories). That 8 times bigger than the average=A0
> > ((80/2)/(400/76))! There are either common stuff that should be
> > shared, or some stuff should be moved in drivers.
>=A0
> Here are some additional data points you might consider adding to
> your analysis:
>=A0
> - Consider taking into account what percentage of those lines are for=
=A0
> =A0 SoC-specific device data files. =A0Where should those files be mo=
ved,=A0
> =A0 before a DT (or other data format) conversion?
Soc specific data are mainly in file starting with board* on omap and t=
ake only=A015 KSLOC.

Most of code come from=A0=A0omap_device, clock, powerdomain, hwmod, mux=
 code (in mach-omap2 more than 30KSLOC for=A0clock* omap_hwmod* mux*)
This code won't be removed when we switch to DT, and I believe this cod=
e can be shared with others.

=46or each driver/framework in bsp (plat-*/mach-*) it could be interest=
ing to have an=A0answer=A0to the following questions :=A0
- what it does
- why it is specific to this SOC
- can it be usefull for other SOC
- can an existing framework be used/enhanced

=46or example the mux code it a common problem to all SOC and is not sp=
ecific to omap. Having a generic framework could be great (pinmux ?)=A0


hwmod [1] doesn't look like specific to OMAP and can apply to any arm S=
OC. Why should it be in omap code ?
Platform_bus is limited (see my example on pci like bus) and arm may ne=
ed a better bus. Why not omap_device/hwmod ?

This make me think of the time when linux didn't get a wifi stack and e=
ach driver came with its own stack.


> - Consider accounting for the extra code and data needed for
> fine-grained power management, compared to the average SoC core code,
> assuming the SoC supports it.
Yes omap=A0is fine tuned for power management, but the power management=
 concept is not limited to omap and can be shared.
See for example the pm_runtime framework that can be used by everybody =
(pc, arm, ...).



[1]
=A0* One way to view an OMAP SoC is as a collection of largely unrelate=
d
=A0* IP blocks connected by interconnects. =A0The IP blocks include
=A0* devices such as ARM processors, audio serial interfaces, UARTs,
=A0* etc. =A0Some of these devices, like the DSP, are created by TI;
=A0* others, like the SGX, largely originate from external vendors. =A0=
In
=A0* TI's documentation, on-chip devices are referred to as "OMAP
=A0* modules." =A0Some of these IP blocks are identical across several
=A0* OMAP versions. =A0Others are revised frequently.
[...]
* OMAP hwmod provides a consistent way to describe the on-chip
=A0* hardware blocks and their integration into the rest of the chip.
=A0* This description can be automatically generated from the TI
=A0* hardware database. =A0OMAP hwmod provides a standard, consistent A=
PI
=A0* to reset, enable, idle, and disable these hardware blocks. =A0And
=A0* hwmod provides a way for other core code, such as the Linux device=
=A0
=A0* code or the OMAP power management and address space mapping code,
=A0* code or the OMAP power management and add
ress space mapping code,
=A0* to query the hardware database.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
