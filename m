From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Thu, 23 Jun 2011 16:33:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2816@dbde02.ent.ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
 <BANLkTin6ZShO-fmcA-FOm5f+XdhnR3iLDA@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D6C27CB@dbde02.ent.ti.com>
 <BANLkTinia6hMs7UjjoT=qjqgZVM9XL3ggQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37268 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758941Ab1FWLDe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 07:03:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5NB3VU0012880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 06:03:33 -0500
In-Reply-To: <BANLkTinia6hMs7UjjoT=qjqgZVM9XL3ggQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: K, Mythri P=20
> Sent: Thursday, June 23, 2011 4:30 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Subject: Re: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to=20
> pass base_address
>=20
> Hi Sanjeev,
>=20
> <snip>
> >> >
> >> > =A0 =A0 The changes in the patch aren't limited to DSS alone.
> >> > =A0 =A0 See updated to hdmi_core_audio_config(),
> >> hdmi_wp_audio_config_format(),
> >> > =A0 =A0 hdmi_wp_audio_config_dma(), etc.
> >> >
> >> The changes are related to the HDMI driver which as of=20
> this patch is
> >> in DSS. You see any concerns ? It is only later that those=20
> functions
> >> are moved out .
> >
> > [sp] The subject of mail indicates that changes are meant for DSS.
> > =A0 =A0 How are the functions I quoted related to DSS? Unless=20
> DSS on OMAP4
> > =A0 =A0 supports audio...
> >
> Some of the Audio configuration for HDMI is part of DSS (as of 2.6.40=
)
> , This patch series is precisely to separate the DSS portion from
> non-DSS portion of HDMI.
> It would be great if you have a look at the 2.6.40 kernel and this
> gitorious tree with my patch set to get a fair idea.
>=20

[sp] Then I suggest dropping "DSS" from the subject.

~sanjeev--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
