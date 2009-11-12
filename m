From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] AM35xx: Clock table updates for AM3505/17
Date: Thu, 12 Nov 2009 05:08:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911120508060.14346@utopia.booyaka.com>
References: <1257417540-21120-1-git-send-email-ranjithl@ti.com> <7A436F7769CA33409C6B44B358BFFF0C012AFCC9D8@dlee02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB92EEBC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49673 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbZKLMIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 07:08:31 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB92EEBC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 6 Nov 2009, Lohithakshan, Ranjith wrote:

> > -----Original Message-----
> > From: Menon, Nishanth
> > Sent: Thursday, November 05, 2009 9:55 PM

...

> > > +	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X | CK_35XX),
> > > +	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2 | CK_35XX),
> > > +	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X | CK_35XX),
> > > +	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X | CK_35XX),
> > [...]
> > Could we have CK_3XXX? I mean this would probably happen when 36/37xx gets
> > introduced also.. does that make sense?
> > 
> Yes, it would help to have a CK_3XXX defined to cover all common OMAP3 clocks. 
> The tables would look simpler going forward.
> 
> Paul, what do you think?

Sounds like a good idea to me.

- Paul
