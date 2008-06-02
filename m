From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Mon, 2 Jun 2008 20:28:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593011132AD90@dbde02.ent.ti.com>
References: <1212406192.32058.18.camel@kj-ubuntu>
 <CC3604C1-277A-4CE1-9B3D-EE0ADFB97E3E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51448 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbYFBO6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 10:58:37 -0400
In-Reply-To: <CC3604C1-277A-4CE1-9B3D-EE0ADFB97E3E@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Koen,

You need to use NTargets from E-fuse for the correct operation. If E-fuse reads zero, then you are using a device without SmartReflex support or not guaranteed at least.

#define CONTROL_FUSE_OPP1_VDD1           0x48002380
#define CONTROL_FUSE_OPP2_VDD1           0x48002384
#define CONTROL_FUSE_OPP3_VDD1           0x48002388
#define CONTROL_FUSE_OPP4_VDD1           0x4800238C
#define CONTROL_FUSE_OPP5_VDD1           0x48002390

#define CONTROL_FUSE_OPP1_VDD2           0x48002394
#define CONTROL_FUSE_OPP2_VDD2           0x48002398
#define CONTROL_FUSE_OPP3_VDD2           0x4800239C

#define CONTROL_FUSE_SR                  0x480023A0

Those values present in the driver are meant for testing purposes only. Ideally in sr_enable, if current_nvalue reads zero we should return without enabling SmartReflex module.


        current_nvalue = sr_read_reg(sr, NVALUERECIPROCAL);

        if (nvalue_reciprocal == 0) {
                DPRINTK("OPP doesn't support SmartReflex\n");
                return;
        }

        if (current_nvalue == nvalue_reciprocal) {
                DPRINTK("System is already at the desired voltage level\n");
                return;
        }

This driver needs modification to read NTargets from E-fuse rather than using hard coded values.

Regards,
Pratheesh


-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
Sent: Monday, June 02, 2008 6:02 PM
To: Kalle Jokiniemi
Cc: linux-omap
Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 2 jun 2008, om 13:29 heeft Kalle Jokiniemi het volgende geschreven:

> Here is an updated version of the SmartReflex driver.
>
> Patches 1 and 2 are same as before, but patch 3 has some new things:
>
> - Changed the register accessing to use the prm_xxx_mod_reg{_bits}()
>  functions.
>
> - Created a Kconfig entry for SmartReflex in "System type->TI OMAP
>  Implementations" menu.
>
> Tested on 3430SDP.

Compiles for beagleboard, but the board hangs after:

echo -n 1 > /sys/power/sr_vdd1_autocomp
echo -n 1 > /sys/power/sr_vdd2_autocomp

But that's likely to be a beagleboard specific problem.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIQ+g/MkyGM64RGpERAqwgAJ97AE4z0bIBZJs7nZcO1Npa8YkIcgCfY6KM
3Hhr4AIdmzNiozdqs1uQUgg=
=rcQP
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
