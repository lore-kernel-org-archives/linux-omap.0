From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [patch v4 3/3] arm: omap4: support pmu
Date: Sat, 14 May 2011 10:49:20 +0100
Message-ID: <20110514094920.GA6803@n2100.arm.linux.org.uk>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com> <1299598729-27974-4-git-send-email-tom.leiming@gmail.com> <BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com> <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37690 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1ENJu2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 May 2011 05:50:28 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Rabin Vincent <rabin@rab.in>, linux-omap@vger.kernel.org, Woodruff Richard <r-woodruff2@ti.com>, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org

On Sat, May 14, 2011 at 04:48:52PM +0800, Ming Lei wrote:
> Hi Rabin,
>=20
> 2011/5/14 Rabin Vincent <rabin@rab.in>:
> > What happened to this patch? =A0It is neither in mainline nor in
> > linux-next.
> >
>=20
> This patch depends on the two with titles:
>=20
>       introduce cross trigger interface helpers
>       pmu: allow platform specific irq enable/disable handling
>=20
> and the above patches have been submitted to RMK's patch system
> as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk=
,
> so I can't ask omap guys to merge this one into their tree now.

Given the state of linux-next, which isn't showing much in the way of
consolidation by anyone other than what's in my tree, I'm _desperately_
avoiding adding any new code for this coming merge window.  In fact, th=
e
picture in linux-next is looking worse than the state of my tree.

=46or arch/arm, my tree looks like this:

 256 files changed, 1022 insertions(+), 14022 deletions(-)

And for-next:

 748 files changed, 15066 insertions(+), 26209 deletions(-)

So there's a net reduction of 13000 lines in my tree, compared to a net
reduction of 11143 lines in linux-next - so a net increase of 1857 line=
s
for arch/arm from trees which aren't my tree.

This is rather disappointing, and if linux-next really does reflect the
current state across all ARM trees, it means that we have to keep the
consolidation agenda running into the next merge cycle.

So, I really can not afford to be adding new stuff into my tree at the
present time.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
