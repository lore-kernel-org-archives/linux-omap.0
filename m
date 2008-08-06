From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Update BeagleBoard defconfig
Date: Wed, 6 Aug 2008 11:57:48 +0300
Message-ID: <20080806085748.GG19813@atomide.com>
References: <48989EC0.4020806@googlemail.com> <0680EC522D0CC943BC586913CF3768C00208C1571C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58953 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbYHFI5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 04:57:52 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208C1571C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Syed Mohammed, Khasim <khasim@ti.com> [080806 05:30]:
> Acked-by: Syed Mohammed Khasim <khasim@ti.com>

Pushing today.

Tony


> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Dirk
> > Behme
> > Sent: Wednesday, August 06, 2008 12:11 AM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH] ARM: OMAP3: Update BeagleBoard defconfig
> >
> > From: Dirk Behme <dirk.behme@gmail.com>
> >
> > Update BeagleBoard defconfig:
> >
> > - Use MPU timer instead of 32k timer to work around serial hang issue
> > - Disable CONFIG_DEBUG_LL
> >
> > Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
