From: Pankaj Jangra <jangra.pankaj9@gmail.com>
Subject: Re: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 21:27:44 +0530
Message-ID: <CADTbHxrWwYQK+ei7yy7RYuD1dvHg2mL-yajLnzwjg=h=UzBt3w@mail.gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
	<1340372890-10091-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47093 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab2FVP5p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 11:57:45 -0400
Received: by dady13 with SMTP id y13so2502692dad.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Jun 2012 08:57:44 -0700 (PDT)
In-Reply-To: <1340372890-10091-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

HI,

On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_pr=
epare()
> for omap gpio debounce clock.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0drivers/gpio/gpio-omap.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)

Reviewed-by: Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
