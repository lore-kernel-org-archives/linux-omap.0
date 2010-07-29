From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
Date: Thu, 29 Jul 2010 08:14:06 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D2F3F83@dlee03.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A01E@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A1B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757366Ab0G2NOJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 09:14:09 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A1B6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Marathe, Yogesh" <yogesh_marathe@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

Yogesh,

Nice to see your email.

> > > +/* Release a spinlock */
> > > +int hwspinlock_unlock(struct hwspinlock *handle)
> > > +{
> > > +     if (WARN_ON(handle == NULL))
> > > +             return -EINVAL;
> > > +
> > > +     /* Release it by writing 0 to it */
> > > +     writel(0, handle->lock_reg);
> 
> [[Yogesh Marathe]] Releasing the spinlock without knowing who owns it is
> risky. There should be a check for ownership and if authenticated user has
> called this api  only then it should be released otherwise permission
> denied error should be returned.

-- I think if there is another Kernel client that is trying to release that is not owned by it then that Kernel client itself is buggy and needs to be fixed. Please share your thoughts on how we can ensure that we can add some protection.


> 
> > > +
> > > +     pm_runtime_put(&handle->pdev->dev);
> > > +
> > > +     return 0;

Thank you,
Best regards,
Hari
