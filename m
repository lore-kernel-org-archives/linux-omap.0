From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] mtd: nand: omap: add support for hardware BCH ecc
Date: Fri, 20 Apr 2012 14:12:27 +0300
Message-ID: <CANOLnOOjrZEbPByOD3EQTZ3vn2ZO0SMdyYo1oME_NLRyYciXUQ@mail.gmail.com>
References: <1334915328-10673-1-git-send-email-ivan.djelic@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48596 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab2DTLM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 07:12:29 -0400
Received: by lbom4 with SMTP id m4so3850924lbo.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 04:12:27 -0700 (PDT)
In-Reply-To: <1334915328-10673-1-git-send-email-ivan.djelic@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: linux-mtd@lists.infradead.org, Jan Weitzel <J.Weitzel@phytec.de>, linux-omap@vger.kernel.org

On Fri, Apr 20, 2012 at 12:48 PM, Ivan Djelic <ivan.djelic@parrot.com> =
wrote:
> Hello,
> This patch provides hardware NAND BCH ecc support for OMAP3 boards.
> It depends on the following patches:
>
> new GPMC BCH api (linux-omap):
> http://lists.infradead.org/pipermail/linux-mtd/2012-April/040757.html
>
> race condition fix in OMAP mtd driver:
> http://lists.infradead.org/pipermail/linux-mtd/2012-April/040724.html

I don't have this one in my mailbox (looked up through the archives),
so commenting about it here. What about just dropping omap_wait()
instead? I think gpmc_nand_read(.. GPMC_NAND_DATA) is equivalent to
ordinary data read, knowing that omap_wait() looks like a duplicate of
generic nand_wait(), just without LED support.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
