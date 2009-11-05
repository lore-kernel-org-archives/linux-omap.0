From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] AM35xx: Clock table updates for AM3505/17
Date: Thu, 5 Nov 2009 21:56:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C862AA@dbde02.ent.ti.com>
References: <1257417540-21120-1-git-send-email-ranjithl@ti.com>,<7A436F7769CA33409C6B44B358BFFF0C012AFCC9D8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46689 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756679AbZKEQaI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2009 11:30:08 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA5GUB3B010360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 5 Nov 2009 10:30:13 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA5GUARA020159
	for <linux-omap@vger.kernel.org>; Thu, 5 Nov 2009 22:00:10 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012AFCC9D8@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Lohithakshan, Ranjith" <ranjithl@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon wrote:
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Ranjith Lohithakshan
> > Sent: Thursday, November 05, 2009 2:39 AM
> [...]
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-
> > omap2/clock34xx.c
> > index c258f87..9ac5c0e 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -93,140 +93,143 @@ struct omap_clk {
> >  #define CK_343X              (1 << 0)
> >  #define CK_3430ES1   (1 << 1)
> >  #define CK_3430ES2   (1 << 2)
> > +#define CK_3517      (1 << 3)
> > +#define CK_3505      (1 << 4)
> > +#define CK_35XX      (CK_3517 | CK_3505)
> >
> >  static struct omap_clk omap34xx_clks[] = {
> > -     CLK(NULL,       "omap_32k_fck", &omap_32k_fck,  CK_343X),
> > -     CLK(NULL,       "virt_12m_ck",  &virt_12m_ck,   CK_343X),
> > -     CLK(NULL,       "virt_13m_ck",  &virt_13m_ck,   CK_343X),
> > -     CLK(NULL,       "virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),

Just something that I thought of when I saw this line.

Do we still support OMAP3430 ES1.0 silicon? I don't know if any of
these boards exist in the wild and if they still work with current code.

If we don't mind dropping support for these boards, then maybe we
could remove the *3430ES2* flags and cut down on some code?

Just a thought.

- Anand
