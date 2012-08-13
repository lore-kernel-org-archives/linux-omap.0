From: Matthias Kaehlcke <matthias.list@kaehlcke.net>
Subject: Re: [PATCH] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Mon, 13 Aug 2012 22:02:50 +0200
Message-ID: <20120813200250.GA3822@darwin>
References: <1342776601-8773-1-git-send-email-anilkumar@ti.com>
 <20120813082732.GA31722@darwin>
 <331ABD5ECB02734CA317220B2BBEABC13EA11ABF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a83-160-107-163.adsl.xs4all.nl ([83.160.107.163]:39140 "EHLO
	d4rwin.no-ip.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab2HMUDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 16:03:49 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA11ABF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi AnilKumar,

El Mon, Aug 13, 2012 at 01:35:55PM +0000 AnilKumar, Chimata ha dit:

> > also the tps65217_board structure should be renamed to something li=
ke
> > tps65217_regulators, now that it is specific to the regulator
>=20
> Not required because tps65217_board might contain platform data for W=
LED/
> Battery charger driver if require. So the struct was named as tps6521=
7_board

the patch moves the allocation of the structure to the regulator
driver, so either it should be a subdevice specific structure or a
chip specific one which is allocated in the mfd driver. otherwise the
regulator driver will allocate memory which is never used when struct
tps65217_board is extended for other subdevices. and the same would
happen in the other subdevice drivers if they choose to allocate their
own struct tps65217_board instead of a sub-structure with just the
fields needed by the specific driver

regards

--=20
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

    Yo soy como soy y t=FA eres como eres, construyamos un mundo donde =
yo
    pueda ser sin dejar de ser yo, donde t=FA puedas ser sin dejar de s=
er
    t=FA, y donde ni yo ni t=FA obliguemos al otro a ser como yo o como=
 t=FA
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
