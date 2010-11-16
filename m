From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: enable L2 prefetching
Date: Tue, 16 Nov 2010 10:11:57 -0800
Message-ID: <20101116181157.GY9264@atomide.com>
References: <1289838044-32016-1-git-send-email-nm@ti.com>
 <yw1xaala8qex.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45399 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0KPSMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 13:12:06 -0500
Content-Disposition: inline
In-Reply-To: <yw1xaala8qex.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> [101115 09:01]:
> Nishanth Menon <nm@ti.com> writes:
>=20
> > From: Mans Rullgard <mans@mansr.com>
> >
> > Enabling L2 prefetching improves performance as shown on Panda
> > ES2.1 board with mem test, and it has measurable impact on
> > performances. I think we should consider it, even though it damages
> > "writes" a bit. (rebased to k.org)
> > Usually the prefetch is used at both levels together L1 + L2, howev=
er,
> > to enable the CP15 prefetch engines, these are under security, and =
on
> > GP devices, we cannot enable it(e.g. on PandaBoard). However, just
> > enabling PL310 prefetch seems to provide performance improvement,
> > as shown in the data below (from Ubuntu) and would be a great thing
> > to pull in.
>=20
> What this does is enable automatic next line prefetching.  With this
> enabled, whenever the PL310 receives a cachable read request, it
> automatically prefetches the following cache line as well.  A larger
> offset can be programmed in secure mode, but the TI ROM authors
> neglected to include this.
>=20
> Testing with FFmpeg showed a speedup of 10% with this patch in some
> cases.

M=C3=A5ns and Nishant, care to repost this with the updated comments?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
