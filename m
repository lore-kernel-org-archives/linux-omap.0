From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Request for OMAPDSS testing
Date: Thu, 13 Jun 2013 18:51:23 +0300
Message-ID: <51B9EA7B.8070906@compulab.co.il>
References: <51AD99F5.7060506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:43134 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758295Ab3FMPvc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 11:51:32 -0400
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

Works on cm-t3730.
Tested with tdo24m LCD and DVI.

Although one thing is missing from the tfp410 driver is
the PD GPIO polarity. I had to adjust it locally to get the DVI working.
The original polarity was high = disabled, low = enabled.


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuep6AAoJEBDE8YO64EfaXsIP/19xfE9BlqtswMRgr3uOEaJf
gnh9JcwMebMWiCFcyCw96EP7C/oW6GmVdyGDLnZmjJ9ZqA1al0I4Lia1LDJDNxtZ
EDLIAaY1Wf4JN0wcVVAy1o4jHiYu6jpLLME3JNXGU6HwUgrSEcXOBd62veIjHcE3
f1p3HvGvfXJxU0/7JCohpRteTIqXjmG9BxBcyAnes0lhBozOwIOO0uLtiH+XeSJe
Sn907bkdFk6qG8m+FSQWyJZMKLGZuE0nNOQ2obMeXk6nvj8TnO9x4W51I5DnsfgT
ZnCtcnuC3RGLo1YmUBFSBDLsd9VZgD3K2c/ysfpwM9Os2XvImGbUkX6ToJ4iMr0T
Ika2ljsMCbObbqQGiSbEM7JiOOc5QL6AB4b+uwD8VEDd4JwzkaMugBSYn8B38y5u
PxCFWMihZGlyWVHS+qwON+cS59Y1xj0b7pvQRlar+ufQDk/gQBPNbJFnzIaU8B3D
6qx9TL7QmPJ172+dVIbcWLMMLLwa5ityajIaETgmQw6GMNLyUghf50I6k8rRHnzc
JA3UFkeYGplYfVPHpWM2fNvSDin9yTELbGty0QzszlUWRHqpmXlyEYk/VMShWE8h
LNKv+FZ1VwNFD3PmZINVB4IWflT9X/52hgrrACxBVAPG7xhahGA+XV6e10zc1cPd
7dnQIlL7OugAAWC5ttaw
=sLEz
-----END PGP SIGNATURE-----
