From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
Date: Tue, 24 Jan 2012 00:09:04 -0800
Message-ID: <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
	<1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64187 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab2AXIJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 03:09:06 -0500
Received: by wics10 with SMTP id s10so2737554wic.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 00:09:05 -0800 (PST)
In-Reply-To: <1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>

Hi,

On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com> =
wrote:
=2E..
> =A0include/linux/mtd/mtd.h | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 1a81fde..c717bb6 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -427,9 +427,9 @@ static inline int mtd_is_locked(struct mtd_info *=
mtd, loff_t ofs, uint64_t len)
>
> =A0static inline int mtd_suspend(struct mtd_info *mtd)
> =A0{
> - =A0 =A0 =A0 if (!mtd->suspend)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> - =A0 =A0 =A0 return mtd->suspend(mtd);
> + =A0 =A0 =A0 if (mtd->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mtd->suspend(mtd);
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static inline void mtd_resume(struct mtd_info *mtd)

I believe this fix is already accounted for in Artem Bityutskiy's
l2-mtd-2.6 repository as:

commit 091a7fe219ee8d3e76be9e02221433af10c6f574
mtd: fix MTD suspend
(http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/091a7fe2=
19ee8d3e76be9e02221433af10c6f574)

However, the bug made it into the 3.3 merge window, so shouldn't this
bugfix be sent upstream immediately?

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
