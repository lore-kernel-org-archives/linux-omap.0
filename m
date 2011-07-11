From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch in mutex
 lock-unlock
Date: Mon, 11 Jul 2011 18:40:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DA7AA59@dbde02.ent.ti.com>
References: <1310129879-4748-1-git-send-email-premi@ti.com>
 <20110709085124.401dba10@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45961 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792Ab1GKNLf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 09:11:35 -0400
In-Reply-To: <20110709085124.401dba10@endymion.delvare>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org] 
> Sent: Saturday, July 09, 2011 12:21 PM
> To: Premi, Sanjeev
> Cc: lm-sensors@lm-sensors.org; linux-omap@vger.kernel.org
> Subject: Re: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch 
> in mutex lock-unlock
> 
> On Fri, 8 Jul 2011 18:27:59 +0530, Sanjeev Premi wrote:
> > A mutex is locked on entry into twl4030_madc_conversion().
> > Immediate return on some error conditions leaves the
> > mutex locked.
> > 
> > This patch ensures that mutex is always unlocked before
> > leaving the function.
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > Cc: Keerthy <j-keerthy@ti.com>
> > ---
> > 
> >  Compile tested only.
> > 
> > 
> >  drivers/mfd/twl4030-madc.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> > index 3941ddc..b5d598c 100644
> > --- a/drivers/mfd/twl4030-madc.c
> > +++ b/drivers/mfd/twl4030-madc.c
> > (...)
> 
> Wrong list. This isn't a hwmon driver, so lm-sensors isn't suitable.
> scripts/get_maintainer.pl says that you should send this patch to:
> Samuel Ortiz <sameo@linux.intel.com>

[sp] I picked the list from the patch where this functionality was first
     introduced. Assumed that Samuel would on this list itself...

     sorry for noise :(

~sanjeev

> 
> Thanks,
> -- 
> Jean Delvare
> 