From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [PATCH v2 08/13] OMAP2+: McBSP: hwmod adaptation
 for McBSP
Date: Thu, 17 Feb 2011 15:41:40 -0800
Message-ID: <20110217234140.GH20795@atomide.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
 <1296485437-12806-9-git-send-email-kishon@ti.com>
 <4D47FB19.9040901@nokia.com>
 <20110201194436.74826dd0.jhnikula@gmail.com>
 <AANLkTimzjg3+yGwz1sa+dfWyrjaS1mO+zn_LT3hhDHdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64485 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab1BQXlz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 18:41:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimzjg3+yGwz1sa+dfWyrjaS1mO+zn_LT3hhDHdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com

* ABRAHAM, KISHON VIJAY <kishon@ti.com> [110201 22:22]:
> On Tue, Feb 1, 2011 at 11:14 PM, Jarkko Nikula <jhnikula@gmail.com> w=
rote:
> > On Tue, 01 Feb 2011 14:22:49 +0200
> > Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> >
> >> Looks good, but...
> >> > + =C2=A0 if (oh->class->rev =3D=3D MCBSP_CONFIG_TYPE3) {
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id =3D=3D 2)
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pdata->buffer_size =3D 0x500; /*FIFO size is 1024 + 256*/
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pdata->buffer_size =3D 0x80; =C2=A0/*FIFO size is 128*/
> >> > + =C2=A0 }
> >>
> >> I would add spaces around these comments (after /* and before */).
> >>
> > Actually this part of code doesn't compile for CONFIG_ARCH_OMAP2 if
> > CONFIG_ARCH_OMAP3 is not set. Reason is that the buffer_size in und=
er
> > CONFIG_ARCH_OMAP3 compilation in struct omap_mcbsp_platform_data
> > definition.
> >
> > I think it's easiest if this patch just removes that conditional
> > compilation from struct omap_mcbsp_platform_data as it really doesn=
't
> > save that much from non !OMAP3 builds.
>=20
>   Thanks. Will fix it in the next version.

Any news on updating this series?

Note that you can now leave out the omap4 hwmod data as that has
been merged to omap-for-linus.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
