From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix compile break
Date: Sat, 29 Oct 2011 23:24:02 -0700
Message-ID: <CAFm5wm15LQBZU4_MxK51SDutmrkR5JJCyE2UHndyvpMrXtvLrg@mail.gmail.com>
References: <1319931847-5140-1-git-send-email-vikram.pandita@ti.com> <201110300239.55207.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56840 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604Ab1J3GYY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Oct 2011 02:24:24 -0400
Received: by qabj40 with SMTP id j40so4458307qab.19
        for <linux-omap@vger.kernel.org>; Sat, 29 Oct 2011 23:24:23 -0700 (PDT)
In-Reply-To: <201110300239.55207.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sat, Oct 29, 2011 at 5:39 PM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
>
> > From: Vikram Pandita <vikram.pandita@ti.com>
> >
> > omap_hsmmc.c: In function 'omap_hsmmc_protect_card':
> > omap_hsmmc.c:1273: error: 'pr_info' undeclared (first use in this f=
unction)
> > omap_hsmmc.c:1273: error: (Each undeclared identifier is reported o=
nly once
> > omap_hsmmc.c:1273: error: for each function it appears in.)
> > omap_hsmmc.c:1273: error: expected ';' before string constant
> > omap_hsmmc.c:1275: error: expected statement before ')' token
> >
> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > ---
> > =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_=
hsmmc.c
> > index e8ff123..101cd31 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct
> > omap_hsmmc_host *host) }
> > =A0 =A0 =A0 } else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->protect_card) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info"%s: cover is open=
, "
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: cover is ope=
n, "
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"card is now inaccessible\n",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0mmc_hostname(host->mmc));
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->protect_card =3D =
1;
>
> Hey,
>
> please care to check mailing list next time before you submit patch.

Cool down sir, no need to sound like hell broke loose.
If its already there, i may have missed it.

Please ignore.

> This is
> already fixed for about five hours now. Actually, the last patch subm=
itted to
> the mailing list fixes exactly this problem:
>
> [PATCH] omap_hsmmc: fix missing parenthesis in pr_info
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
