From: Lee Jones <lee.jones@linaro.org>
Subject: Re: mfd: twl-core: Return directly after a failed
 platform_device_alloc() in add_numbered_child()
Date: Tue, 17 May 2016 07:00:59 +0100
Message-ID: <20160517060059.GB17238@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <3c168185-ec2d-f1f7-fe70-8a230b884ed2@users.sourceforge.net>
 <alpine.DEB.2.02.1605160845050.2060@localhost6.localdomain6>
 <9f94708f-6433-5227-78ee-52fbfb30fdaf@users.sourceforge.net>
 <alpine.DEB.2.02.1605161006350.2060@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1605161006350.2060@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 16 May 2016, Julia Lawall wrote:

> On Mon, 16 May 2016, SF Markus Elfring wrote:
>=20
> > >> * Change an error message.
> > >=20
> > > Why?  Is dev_err needed?
> >=20
> > I interpreted Lee's response in this way.
> > https://lkml.org/lkml/2016/1/11/104
>=20
> OK.  He didn't ask for the message to be changed though.  It's a bit=20
> unfortunate that it now takes up multiple lines.  And I believe it al=
so=20
> prints redundant information.  Perhaps he will have some further thou=
ghts=20
> on the matter.

Yes, Julia is right.  We normally don't print anything for OOM
errors since Linux reports on them already.

Please remove the print altogether.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
