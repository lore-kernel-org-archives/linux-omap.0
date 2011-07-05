From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: AM3505/3517 support
Date: Tue, 5 Jul 2011 15:29:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D91A50F@dbde02.ent.ti.com>
References: <4E121485.6060700@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab1GEJ7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 05:59:38 -0400
In-Reply-To: <4E121485.6060700@8d.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rapha=EBl Ass=E9=
nat
> Sent: Tuesday, July 05, 2011 12:59 AM
> To: linux-omap@vger.kernel.org
> Subject: AM3505/3517 support
>=20
> Hello,
>=20
> We have a custom designed based on the AM3505 and we wish to=20
> run a modern kernel
> on it. Unfortunately, it seems a lot of efforts have been=20
> made to support other=20
> OMAP chips and that some work is still required to support=20
> the AM3505/3517=20
> completely. (does not boot as-is)
>=20
> Is there anyone working on this right now? Not knowing, I=20
> have already started
> working on it.
>=20
> The am3505 is apparently so similar to the 3430 that it was=20
> treated as such=20
> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There=20
> are however a
> few differences that need to be addressed. I have therefore=20
> created a new
> CHIP_IS and patched clocks, hwmod and power management related files
> consequently. My system now boots until it complains that it=20
> is unable=20
> to mount its root filesystem.
>=20
> I will send my patches in a moment for comments and=20
> hopefully, after a=20
> few iterations, they will be acceptable. I know a lot of cleanup is=20
> happening right now and as a result my patches may not apply=20
> or conflict.=20
> Please let me know and I will be happy to rebase them as needed.
>=20
> Looking forward to your comments and help.=20
>=20
> One of the next things I'll look at is how to properly=20
> support the ZCN package.
> Right now, the CBB package is used (board-am3517evm.c for=20
> instance) but there
> are differences that prevent some GPIOs from being configured=20
> properly. It would
> be nice to know if someone is working on this before I start...

Raphael,

The AM35x support has been trailing on the linux-omap. Usually,
due to delays in dependency resolution:

If you are not specifically looking for the latest kernel,
revision you can get the sources from:
http://arago-project.org/git/projects/?p=3Dlinux-omap3.git

Use the tag: v2.6.37_OMAPPSP_04.02.00.07

This tree is supported by TI. The patches contained here, are
being reworked for upstream submission...

~sanjeev

>=20
> Best regards,
> Rapha=EBl Ass=E9nat
> 8D Technologies inc.
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
