From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] AM3505/3517 ZCN package support
Date: Thu, 7 Jul 2011 18:35:10 +0300
Message-ID: <20110707153507.GO15815@atomide.com>
References: <4E1492C0.8060900@8d.com>
 <20110707141957.GG15815@atomide.com>
 <4E15C57F.9020402@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62404 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751710Ab1GGPfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 11:35:15 -0400
Content-Disposition: inline
In-Reply-To: <4E15C57F.9020402@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>

* Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110707 17:36]:
> On 07/07/11 10:19 AM, Tony Lindgren wrote:
> > * Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110706 19:47]:
> >> Fixes according to Sanjeev's comments in previous thread.
> >>
> >> ---
> >> This patch adds support for the AM35xx ZCN package specific muxmod=
es.
> >=20
> > Thanks for doing this. Still it's quite a few lines of data.. So
> > I suggest that we just plan on doing the mux data for v3.2 merge
> > window in device tree format. I'm planning on working on that after
> > v3.1 merge window and should be able to generate it for am3505
> > using your patch.
> Ok, looking forward to testing this.
>=20
> > Otherwise we'll be patching something that will be disappearing
> > quite soon anyways.
> I agree. At least in the meantime my problem is fixed by this patch.

OK, let's do that then.
=20
> This is unrelated to this thread but..=20
> do you think we could merge this one?=20
>=20
> [PATCH 5/5] am3505/3517: Various platform defines for UART4
> http://marc.info/?l=3Dlinux-omap&m=3D130980816418020&w=3D4
>=20
> It does not depend on the other patches in this set so it can be
> applied individually. And those definitions will be needed later
> when full am35xx support is implemented anyway.

Yes that looks good to me, will queue. Do you have some other
bits in your patches that could be merged?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
