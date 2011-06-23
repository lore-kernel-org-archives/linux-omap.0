From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Thu, 23 Jun 2011 16:00:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C27CB@dbde02.ent.ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
 <BANLkTin6ZShO-fmcA-FOm5f+XdhnR3iLDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47662 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758860Ab1FWKa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 06:30:58 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5NAUtpp031438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 05:30:57 -0500
In-Reply-To: <BANLkTin6ZShO-fmcA-FOm5f+XdhnR3iLDA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: K, Mythri P=20
> Sent: Thursday, June 23, 2011 11:21 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Subject: Re: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to=20
> pass base_address
>=20
> Hi Sanjeev,
>=20
> On Mon, Jun 20, 2011 at 7:03 PM, Premi, Sanjeev <premi@ti.com> wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
> >> Sent: Friday, June 17, 2011 1:47 PM
> >> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> >> Cc: K, Mythri P
> >> Subject: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass
> >> base_address
> >
> > [sp] HDMI appears twice on the subject. One of these can be removed=
=2E
> > =A0 =A0 Also, it isn't clear (though implied) whose base=20
> address is being
> > =A0 =A0 passed.
> >
> > =A0 =A0 The changes in the patch aren't limited to DSS alone.
> > =A0 =A0 See updated to hdmi_core_audio_config(),=20
> hdmi_wp_audio_config_format(),
> > =A0 =A0 hdmi_wp_audio_config_dma(), etc.
> >
> The changes are related to the HDMI driver which as of this patch is
> in DSS. You see any concerns ? It is only later that those functions
> are moved out .

[sp] The subject of mail indicates that changes are meant for DSS.
     How are the functions I quoted related to DSS? Unless DSS on OMAP4
     supports audio...

> >>
> >> - =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG1);
> >> + =A0 =A0 r =3D hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1=
);
> >> =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM *=
/
> >> =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regn, 8, 1); =A0/* CFG1_PLL_REGN=
 */
> >>
> >> - =A0 =A0 hdmi_write_reg(PLLCTRL_CFG1, r);
> >> + =A0 =A0 hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1, r);
> >
> > [sp] hdmi_pll_base(ip_data) is used at many places withing this
> > =A0 =A0 function. Have you checked if saving the result in a local
> > =A0 =A0 variable generates any better code than repetitive ADD oper=
ation
> > =A0 =A0 in the function.
> >
> > =A0 =A0 Same comment applies to similar use in other functions
> > =A0 =A0 modified in this patch.
> >
> I had this comment from Tomi as well , Yes in some places it makes
> sense to have a local variable to save , but then in certain function=
s
> where there are four writes with 3 different base address it doesn't
> make sense to add 3 variables.

[sp] I don't see base address for the IP changing within the function.
     so a local variable still makes sense - instead of using CPU cycle=
s
     to do reduntant calculations each time.

> > [snip]...[snip]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ,
> >> HDMI_CORE_DDC_CMD, 0x9, 3, 0);
> >
> > [sp] Misplaced "," at beginning of the line.
> >
> Not a part of the patch i suppose?

[sp] Actually the + indicates it is very much part of the patch.
     Ideally it should be at end of prev line.
     [quote]
      	/* Clear FIFO */
     -	REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
     +	REG_FLD_MOD(hdmi_core_sys_base(ip_data)
     +				, HDMI_CORE_DDC_CMD, 0x9, 3, 0);
     [/quote]=20

~sanjeev
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
