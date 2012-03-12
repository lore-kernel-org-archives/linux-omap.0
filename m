From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Ethernet problems on AM3517, possible regression?
Date: Mon, 12 Mar 2012 15:17:03 -0700 (PDT)
Message-ID: <1331590623.51447.YahooMailNeo@web125202.mail.ne1.yahoo.com>
References: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com> <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com> <1330621988.48456.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1330643793.82609.YahooMailNeo@web125204.mail.ne1.yahoo.com> <1330968742.99498.YahooMailNeo@web125205.mail.ne1.yahoo.com> <4F55D608.3040706@compulab.co.il>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm29-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.189]:37780 "HELO
	nm29-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753418Ab2CLWRF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 18:17:05 -0400
In-Reply-To: <4F55D608.3040706@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Igor,

THANKS SO MUCH FOR YOUR HELP!=A0 Your help has allowed us to fix the is=
sue satisfactorally for now.

-----------

=46or those interested, under our version of Linux (linux-omap-3.2-rc6)=
, the two ports were essentially fighting for MDIO address id 0, and it=
 also appeared the EMAC was trying to bind the SMSC's PHY.=A0 As we sus=
pected, the "fix" was to force one of ports to stop trying to use addre=
ss 0 and to tell the EMAC explicitly which PHY to use.

We tried moving our kernel forward into the 3.3-rcX realm to make patch=
ing easier, but met a bunch of resistance from broken drivers we had wo=
rking in the previous version.=A0 So, we went back.=A0 The changes we m=
ade were to move the EMAC to id '2', as shown below in the snip of our =
board file below.

{{{SNIP}}}
static struct platform_device b3517_mdio_device =3D {
=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D "davinci_mdio",
=A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0 =3D 2,
=A0=A0=A0 .num_resources=A0=A0=A0 =3D ARRAY_SIZE(b3517_mdio_resources),
=A0=A0=A0 .resource=A0=A0=A0 =3D b3517_mdio_resources,
=A0=A0=A0 .dev.platform_data =3D &b3517_mdio_pdata,
};

static struct emac_platform_data b3517_emac_pdata =3D {
=A0=A0=A0 .phy_id=A0=A0=A0 =A0=A0=A0 =3D "2:00",
=A0=A0=A0 .rmii_en=A0=A0=A0 =3D 1,
};
{{{SNIP}}}

The operative argument here was the ".phy_id" directive Igor passed alo=
ng.=A0 This forces the EMAC to grab a specific PHY, not just the first =
one sees, which for us always seemed to be the SMSC's.

I'm not sure if it was necessary, but to keep all this in sync, I also =
altered the clock3xxx_data.c patch to setup "mdio.2" instead fo "mdio.0=
".
+=A0=A0=A0 CLK("davinci_emac",=A0=A0=A0 NULL,=A0=A0=A0 &emac_ick,=A0=A0=
=A0 CK_AM35XX),
+=A0=A0=A0 CLK("davinci_mdio.2",=A0=A0=A0 NULL,=A0=A0=A0 &emac_fck,=A0=A0=
=A0 CK_AM35XX),

Anyway, things are working fine now as best we can tell.

[=A0=A0=A0 1.052795] smsc911x: Driver version 2008-10-21
[=A0=A0=A0 1.059539] smsc911x-mdio: probed
[=A0=A0=A0 1.063110] smsc911x smsc911x: eth0: attached PHY driver [Gene=
ric PHY] (mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
[=A0=A0=A0 1.073852] smsc911x smsc911x: eth0: MAC Address: ??:??:??:??:=
??:??
[=A0=A0=A0 1.120544] davinci_mdio davinci_mdio.2: davinci mdio revision=
 1.5
[=A0=A0=A0 1.127014] davinci_mdio davinci_mdio.2: detected phy mask fff=
ffffe
[=A0=A0=A0 1.134124] davinci_mdio.2: probed
[=A0=A0=A0 1.137786] davinci_mdio davinci_mdio.2: phy[0]: device 2:00, =
driver unknown


We are anxious to move our kernel forward as soon as we reasonably can,=
 as we've noted both the EMAC and SMSC have newer drivers similar board=
s are using.=A0 However, for us at the moment, the brokenness these cha=
nges bring to our effort isn't worth the time to correct it at the mome=
nt.

THANKS AGAIN FOR ALL YOUR HELP!



----------------------------
Hi,

On 03/05/12 19:32, CF Adad wrote:
> Hi Igor,
>=20
>=20
> Thanks for your reply!=A0 So are both ports working on the CM-T3517 s=
imultaneously now?

Well, you need to apply all the patches I've sent you.

>=A0 Looking at the latest board file for the CM-T3517 (arch/arm/mach-o=
map2/board-cm-t3517.c), I don't see either the SMSC or the EMAC ports b=
eing initialized.=A0 Has that initialization code been moved somewhere =
else in the kernel?
>=20

Again, you need to apply the patches I've sent you.

> Regarding the patches:=A0 I had actually seen those (in the previous =
"version #2" I believe), and applied them to our kernel.

v3 is slightly different and you need the patch for the board file.
You need also the patches I've sent you privately.

>=A0 If you take a look at my board file below, you'll notice I defined=
 a "USE_ALT__EMAC_ETH" definition that causes the separate EMAC file (c=
reated by those patches) to be used.=A0 I've tried both the old and the=
 new (separate file) way of doing this.=A0 Our EMAC does work fine, as =
does our SMSC, except our SMSC does not store a MAC address.=A0 They ju=
st do not work together.=A0 One or the other must be disabled (commente=
d out of the code) or neither work.

The patch I've sent you solves exactly that...

>=20
> It appears to me that the problem with running both is the mdio id se=
tting.=A0 Perhaps they're both demanding the same slot or something?

Yes, there were several changes made to MDIO framework and how the whol=
e thing is handled.


--=20
Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
