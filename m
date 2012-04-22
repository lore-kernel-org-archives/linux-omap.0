From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: YUV422 input to CPI?
Date: Sun, 22 Apr 2012 14:11:56 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9F8032@DBDE01.ent.ti.com>
References: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
 <CA+2YH7vpCdXhJUQrsZ+3Tp=b5q=3su1K4TaEumWGeMeCZXpvyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab2DVOMP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 10:12:15 -0400
In-Reply-To: <CA+2YH7vpCdXhJUQrsZ+3Tp=b5q=3su1K4TaEumWGeMeCZXpvyw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enrico <ebutera@users.sourceforge.net>, Simon Knopp <simon.knopp@pg.canterbury.ac.nz>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

On Fri, Apr 20, 2012 at 15:56:46, Enrico wrote:
> On Thu, Apr 19, 2012 at 11:56 PM, Simon Knopp
> <simon.knopp@pg.canterbury.ac.nz> wrote:
> > Hi all,
> >
> > I have a camera module capable of outputting YUV422 over a parallel=
 interface. I've been having some issues interfacing this to a Gumstix.=
 Reading through the OMAP3530 tech ref, I'm now beginning to wonder whe=
ther it is actually possible to input YUV422 to the CPI?
> >
> > - =A0Section 12.1.1 mentions RGB and YeCyMgG for "image sensors"; Y=
UV is only mentioned for CS1&2.
> > - =A0On the other hand, 12.4.6.1 says that the CCDC accepts YUV dat=
a in numerous formats.
> >
> > Is anyone able to confirm whether it's possible to input YUV422 to =
the CPI?
>=20
> Yes it's possible but yuv support is still not in mainline kernel.
>=20
> Have a look at the linux-media ml archive to know what is the current
> status, problems etc...basically if you don't need bt656 support you
> can try the omap3isp-omap3isp-yuv branch at [1].
>=20

During one of the internal releases, I have added YUV (BT656) support, =
it is=20
based on 2.6.37 based kernel, but still it will give you pointer and he=
lp
you to change the code to get support for the same.

I have created separate, clean and independent patches for=20
adding support for BT656 YUV support.


http://arago-project.org/git/projects/?p=3Dlinux-omap3.git;a=3Dhistory;=
f=3Ddrivers/media/video/isp;hb=3D20c003f2f024d9f50f59edf9f1b8f5f035fb15=
b8


Thanks,
Vaibhav

> Enrico
>=20
> [1]: http://git.linuxtv.org/pinchartl/media.git
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
