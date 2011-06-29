From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: cleanup NAND platform data
Date: Wed, 29 Jun 2011 01:12:43 -0700
Message-ID: <20110629081243.GA23145@atomide.com>
References: <1307130993-15265-1-git-send-email-notasas@gmail.com>
 <BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
 <BANLkTimXxOcr4q2fkD0hjq4pMVPC0StBFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19696 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752324Ab1F2IMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 04:12:46 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimXxOcr4q2fkD0hjq4pMVPC0StBFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [110603 15:01]:
> On Sat, Jun 4, 2011 at 12:14 AM, Vimal Singh <vimal.newwork@gmail.com=
> wrote:
> > On Sat, Jun 4, 2011 at 1:26 AM, Grazvydas Ignotas <notasas@gmail.co=
m> wrote:
> >>
> >> -static int omap2_nand_gpmc_retime(void)
> >> +static int omap2_nand_gpmc_retime(struct omap_nand_platform_data =
*gpmc_nand_data)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpmc_timings t;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
> >> @@ -83,13 +81,11 @@ static int omap2_nand_gpmc_retime(void)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> >> =C2=A0}
> >>
> >> -int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_d=
ata)
> >> +int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_na=
nd_data)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &gpmc_nand_devic=
e.dev;
> >>
> >> - =C2=A0 =C2=A0 =C2=A0 gpmc_nand_data =3D _nand_data;
> >> - =C2=A0 =C2=A0 =C2=A0 gpmc_nand_data->nand_setup =3D omap2_nand_g=
pmc_retime;
> >
> > Purpose of doing this was to be able to utilise
> > 'omap2_nand_gpmc_retime', when DVFS is ready to use it,
> > for changing timing parameter dynamically when a frequency change i=
s done.
>=20
> Well but it seems currently ...retime() only does single static
> configuration, I guess when it's updated to do DVFS stuff callback ca=
n
> easily be added back..

Applying this into devel-cleanup.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
