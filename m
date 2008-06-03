From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Tue, 3 Jun 2008 13:54:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593011132B103@dbde02.ent.ti.com>
References: <1212406192.32058.18.camel@kj-ubuntu>
	 <CC3604C1-277A-4CE1-9B3D-EE0ADFB97E3E@student.utwente.nl>
	 <B85A65D85D7EB246BE421B3FB0FBB593011132AD90@dbde02.ent.ti.com>
 <1212472944.32058.31.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:54279 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbYFCIZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 04:25:43 -0400
In-Reply-To: <1212472944.32058.31.camel@kj-ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap <linux-omap@vger.kernel.org>

Kalle,

Yes, you are right. You can remove the second if statement.

Regards,
Pratheesh

-----Original Message-----
From: Kalle Jokiniemi [mailto:ext-kalle.jokiniemi@nokia.com]
Sent: Tuesday, June 03, 2008 11:32 AM
To: TK, Pratheesh Gangadhar
Cc: Koen Kooi; linux-omap
Subject: RE: [PATCH 0/3] ARM: OMAP: SmartReflex driver

Hi Pratheesh,

On ma, 2008-06-02 at 20:28 +0530, ext TK, Pratheesh Gangadhar wrote:
> Koen,
>
> You need to use NTargets from E-fuse for the correct operation. If E-fuse reads zero, then you are using a device without SmartReflex support or not guaranteed at least.
>
> #define CONTROL_FUSE_OPP1_VDD1           0x48002380
> #define CONTROL_FUSE_OPP2_VDD1           0x48002384
> #define CONTROL_FUSE_OPP3_VDD1           0x48002388
> #define CONTROL_FUSE_OPP4_VDD1           0x4800238C
> #define CONTROL_FUSE_OPP5_VDD1           0x48002390
>
> #define CONTROL_FUSE_OPP1_VDD2           0x48002394
> #define CONTROL_FUSE_OPP2_VDD2           0x48002398
> #define CONTROL_FUSE_OPP3_VDD2           0x4800239C
>
> #define CONTROL_FUSE_SR                  0x480023A0
>
> Those values present in the driver are meant for testing purposes only. Ideally in sr_enable, if current_nvalue reads zero we should return without enabling SmartReflex module.
>
>
>         current_nvalue = sr_read_reg(sr, NVALUERECIPROCAL);
>
>         if (nvalue_reciprocal == 0) {
>                 DPRINTK("OPP doesn't support SmartReflex\n");
>                 return;
>         }
>
>         if (current_nvalue == nvalue_reciprocal) {
>                 DPRINTK("System is already at the desired voltage level\n");
>                 return;
>         }

This last if-statement is something that puzzled me while I was doing
this patch-set. Shouldn't the SmartReflex be enabled even though we are
at the desired voltage level at a given time. I mean, the operating
conditions (temperature for one) could change over time and smartreflex
will need to do it's magic in order to keep the device at a proper
voltage level, right?


>
> This driver needs modification to read NTargets from E-fuse rather than using hard coded values.

Tony, I can update this patch set, or send an additional patch that adds
the efuse support. Which will you prefer?


Regards,
Kalle


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Monday, June 02, 2008 6:02 PM
> To: Kalle Jokiniemi
> Cc: linux-omap
> Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Op 2 jun 2008, om 13:29 heeft Kalle Jokiniemi het volgende geschreven:
>
> > Here is an updated version of the SmartReflex driver.
> >
> > Patches 1 and 2 are same as before, but patch 3 has some new things:
> >
> > - Changed the register accessing to use the prm_xxx_mod_reg{_bits}()
> >  functions.
> >
> > - Created a Kconfig entry for SmartReflex in "System type->TI OMAP
> >  Implementations" menu.
> >
> > Tested on 3430SDP.
>
> Compiles for beagleboard, but the board hangs after:
>
> echo -n 1 > /sys/power/sr_vdd1_autocomp
> echo -n 1 > /sys/power/sr_vdd2_autocomp
>
> But that's likely to be a beagleboard specific problem.
>
> regards,
>
> Koen
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.5 (Darwin)
>
> iD8DBQFIQ+g/MkyGM64RGpERAqwgAJ97AE4z0bIBZJs7nZcO1Npa8YkIcgCfY6KM
> 3Hhr4AIdmzNiozdqs1uQUgg=
> =rcQP
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
