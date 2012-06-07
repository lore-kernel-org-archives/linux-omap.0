From: CF Adad <cfadad@rocketmail.com>
Subject: Enabling smsc PHY driver + smsc911x driver
Date: Wed, 6 Jun 2012 21:38:51 -0700 (PDT)
Message-ID: <1339043931.32979.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm19-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.59]:37370 "HELO
	nm19-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759760Ab2FGEiw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 00:38:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This seems to be something trivial, but so far we're stumped.=A0 The AM=
35xx has the built-in DaVinci EMAC and the usual GPMC.=A0 Our board use=
s the EMAC coupled with an SMSC LAN8710 PHY for one port, and a seconda=
ry port provided by a LAN9221 wired up through the GPMC.=A0 The trouble=
 is, if I enabled the SMSC PHY code in Linux, *both* ports try to use i=
t.=A0 I suspect it would be better to use the actual driver rather than=
 some generic default, but enabling it causes trouble.=A0 I get somethi=
ng like this:

[=A0=A0=A0 1.119567] smsc911x: Driver version 2008-10-21
[=A0=A0=A0 1.126892] smsc911x-mdio: probed
[=A0=A0=A0 1.130706] smsc911x smsc911x: eth0: attached PHY driver [SMSC=
 LAN8700] (mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
[=A0=A0=A0 1.142608] smsc911x smsc911x: eth0: MAC Address: xx:xx:xx:xx:=
xx:xx
[=A0=A0=A0 1.184112] davinci_mdio davinci_mdio.0: davinci mdio revision=
 1.5
[=A0=A0=A0 1.190612] davinci_mdio davinci_mdio.0: detected phy mask fff=
ffffe
[=A0=A0=A0 1.197998] davinci_mdio.0: probed
[=A0=A0=A0 1.201690] davinci_mdio davinci_mdio.0: phy[0]: device 0:00, =
driver SMSC LAN8710/LAN8720

See how both Ethernets picked it up?=A0 After this, sometimes I see som=
e odd behavior, which makes perfect sense since that is NOT how its wir=
ed up.=A0 If I leave the PHY drivers out all together, I get:

[ 1.347412] smsc911x: Driver version 2008-10-21
[ 1.354644] smsc911x-mdio: probed
[ 1.358245] smsc911x smsc911x.0: eth0: attached PHY driver [Generic PHY=
] (mii_bus:phy_addr=3D0:01, irq=3D-1)
[ 1.368560] smsc911x smsc911x.0: eth0: MAC Address: yy:yy:yy:yy:yy:yy:y=
y
[ 1.416046] davinci_mdio davinci_mdio.2: davinci mdio revision 1.5
[ 1.422546] davinci_mdio davinci_mdio.2: detected phy mask fffffffe
[ 1.429809] davinci_mdio.2: probed
[ 1.433502] davinci_mdio davinci_mdio.2: phy[0]: device 2:00, driver un=
known

Generic?=A0 Yes, but it seems to work OK.

Is there a way of forcing the LAN9221 to just use the Generic PHY, or p=
erhaps the something internal?=A0 And would there be any benefit if I b=
other?=A0 I've got SMSC911X_FORCE_INTERNAL_PHY set in my flags in the b=
oard file, but that does not seem to be doing anything.

Thanks in advance.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
