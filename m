From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/8] OMAP3+: PM: VP: generalize PRM interrupt helpers
Date: Wed, 7 Sep 2011 21:27:07 +0200
Message-ID: <CAORVsuXzyfWHNyM1u=bXwnhM=yLfF_Q2SS3wjv9n-13mvHcYgw@mail.gmail.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
	<1309393560-8874-3-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f43.google.com ([209.85.212.43]:51987 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab1IGT1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 15:27:09 -0400
Received: by vws10 with SMTP id 10so7635018vws.2
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 12:27:08 -0700 (PDT)
In-Reply-To: <1309393560-8874-3-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>, khilman@ti.com, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Mike, Kevin,

On Thu, Jun 30, 2011 at 2:25 AM, Mike Turquette <mturquette@ti.com> wro=
te:
> From: Nishanth Menon <nm@ti.com>
>
> We have multiple interrupt status hidden in the PRM interrupt status
> reg. Make this handling generic to allow us to pull out LDO status su=
ch
> as those for ABB from it using the same data structure and indexing. =
We
> hence rename accordingly.
I am not sure that the rename is needed.

Kevin, Nishant, what is your opinion?

Regards,
Jean

>
> We also fix a trivial warning as the variable does not need exporting=
:
> arch/arm/mach-omap2/prm2xxx_3xxx.c:172:22: warning: symbol
> 'omap3_prm_irqs' was not declared. Should it be static?
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
> =A0arch/arm/mach-omap2/prm2xxx_3xxx.c | =A0 22 +++++++++++-----------
> =A0arch/arm/mach-omap2/prm2xxx_3xxx.h | =A0 =A07 +++++--
> =A0arch/arm/mach-omap2/prm44xx.c =A0 =A0 =A0| =A0 28 ++++++++++++++--=
------------
> =A0arch/arm/mach-omap2/prm44xx.h =A0 =A0 =A0| =A0 =A07 +++++--
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0 =A0 =A0 | =A0 =A09 ---------
> =A0arch/arm/mach-omap2/vp3xxx_data.c =A0| =A0 =A04 ++--
> =A0arch/arm/mach-omap2/vp44xx_data.c =A0| =A0 =A06 +++---
> =A07 files changed, 40 insertions(+), 43 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
