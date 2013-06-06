From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Request for OMAPDSS testing
Date: Thu, 06 Jun 2013 14:30:04 +0300
Message-ID: <51B072BC.2060002@compulab.co.il>
References: <51AD99F5.7060506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:54011 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932584Ab3FFMCT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jun 2013 08:02:19 -0400
In-Reply-To: <51AD99F5.7060506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tomi,

On 06/04/13 10:40, Tomi Valkeinen wrote:
> Hi guys,
> 
> I've made some big changes on the omapdss device model, which involves
> converting all the panel drivers. I've got only a bunch of boards, so I
> hope some of you can perhaps do some minimal tests on some other boards.
> 
> I've got: Beagle (old one), Panda, 4430SDP, Overo with LCD43.
> 
> The code can be found from the below git branch. It's based on 3.10-rc1.
> 
> git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
> 
> All you need to do to get things working is to enable the new panel
> drivers from kernel config, under Device drivers/Graphics support/OMAP2+
> Display Subsystem support/OMAP Display Device Drivers/

Thanks for the patches.
I still had no chance to look into them.
Hopefully, I will be able to do some tests on the next week.


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsHK8AAoJEBDE8YO64EfaSj8P/ilqGfiSYkZG/ZM4hwv+MFt+
0DllzT8zyHIPZVW7vzP2kCeBymZztpjrEYLkqnnXnv255EcYkAoDEPViHqv0L1h6
dQXSmMOsz9pgYANeDVhNG+PoP0DaBKWihZ7GVZ5MCROW+vSWLRpCIp8fIl7N+EGu
XzFkMSCApuKxFMDOcLppSXAQLdFDcjAeUIiMsYOdnjeNtOy1iXb4metqZ/Ckm7lM
KGP7H5eoHacrDwFZtmy7Glo4L+JEKzCkMfBr1tnMR5uTBDOzQAHDx0EP9mJ7Pjug
gSADHCMa63cCFkXaLKtptBOF8Lgb165XBhs3yRVY/WKm15l815tHQ8rOpWoiaSkx
LR65zuNsYTjMlaLNjJjVtpTb38+v/+IgMZzb7ALJJxsnSYDIXIx2qJkpVy7DVawK
G0Z1xO6xzaxjua0PFv0QWcH7ayI9HKsFr346e2Wk5gNvHTJzQfXN8P/CuMmgeU3o
KNCl+zMQ45bq4U9DfxlNjaswnWiY2GHaN3N8zjgVJCBXEHK7TJ4PSGhzpC262BwL
jKFxebzIPEMJDq1fBu5OQiHx8lyUw+fu0Z64O0x/O2fwYep2/bP3pWUcloLKVK1y
WmUcsl2P7lScchhqNHPYABEDiQDzT+ghp4nX5/WCRdy7qXskO1WPkrZjQaIKBFsX
zwx9ysTRKOYxn0ESCsPw
=QlvU
-----END PGP SIGNATURE-----
