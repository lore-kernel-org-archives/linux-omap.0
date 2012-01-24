From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
	suspend is not implemented
Date: Tue, 24 Jan 2012 09:06:30 +0000
Message-ID: <20120124090630.GR16726@n2100.arm.linux.org.uk>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com> <1327306361-9803-3-git-send-email-shubhrajyoti@ti.com> <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38686 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab2AXJGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 04:06:45 -0500
Content-Disposition: inline
In-Reply-To: <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Artem Bityutskiy <dedekind1@gmail.com>

On Tue, Jan 24, 2012 at 12:09:04AM -0800, Brian Norris wrote:
> Hi,
>=20
> On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com=
> wrote:
> ...
> > =A0include/linux/mtd/mtd.h | =A0 =A06 +++---
> > =A01 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > index 1a81fde..c717bb6 100644
> > --- a/include/linux/mtd/mtd.h
> > +++ b/include/linux/mtd/mtd.h
> > @@ -427,9 +427,9 @@ static inline int mtd_is_locked(struct mtd_info=
 *mtd, loff_t ofs, uint64_t len)
> >
> > =A0static inline int mtd_suspend(struct mtd_info *mtd)
> > =A0{
> > - =A0 =A0 =A0 if (!mtd->suspend)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> > - =A0 =A0 =A0 return mtd->suspend(mtd);
> > + =A0 =A0 =A0 if (mtd->suspend)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mtd->suspend(mtd);
> > + =A0 =A0 =A0 return 0;
> > =A0}
> >
> > =A0static inline void mtd_resume(struct mtd_info *mtd)
>=20
> I believe this fix is already accounted for in Artem Bityutskiy's
> l2-mtd-2.6 repository as:
>=20
> commit 091a7fe219ee8d3e76be9e02221433af10c6f574
> mtd: fix MTD suspend
> (http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/091a7f=
e219ee8d3e76be9e02221433af10c6f574)
>=20
> However, the bug made it into the 3.3 merge window, so shouldn't this
> bugfix be sent upstream immediately?

David is the MTD maintainer, and Artem just helps out.  I believe Artem
is waiting for David to finish travelling before asking David (last see=
n
at Hong Kong airport) to pull these fixes.  David in turn will pass the=
m
onto Linus.  Plus, Linus only started adding to -rc1 yesterday, so its =
a
little early to expect this to be fixed.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
