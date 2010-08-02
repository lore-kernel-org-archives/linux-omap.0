From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
Date: Sun, 1 Aug 2010 20:55:00 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D3FE7B2@dlee03.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A01E@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A1B6@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4D2F3F83@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3AA88@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44817 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0HBBzG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Aug 2010 21:55:06 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3AA88@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Marathe, Yogesh" <yogesh_marathe@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>



Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Marathe, Yogesh
> Sent: Friday, July 30, 2010 1:53 AM
> To: Kanigeri, Hari; Premi, Sanjeev; Linux Omap; Tony Lindgren
> Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon
> Subject: RE: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
> 
> Hari,
> 
> > -----Original Message-----
> > From: Kanigeri, Hari
> > Sent: Thursday, July 29, 2010 6:44 PM
> > To: Marathe, Yogesh; Premi, Sanjeev; Linux Omap; Tony Lindgren
> > Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon
> > Subject: RE: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
> >
> > Yogesh,
> >
> > Nice to see your email.
> >
> > > > > +/* Release a spinlock */
> > > > > +int hwspinlock_unlock(struct hwspinlock *handle)
> > > > > +{
> > > > > +     if (WARN_ON(handle == NULL))
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     /* Release it by writing 0 to it */
> > > > > +     writel(0, handle->lock_reg);
> > >
> > > [[Yogesh Marathe]] Releasing the spinlock without knowing who owns it
> is
> > > risky. There should be a check for ownership and if authenticated user
> has
> > > called this api  only then it should be released otherwise permission
> > > denied error should be returned.
> >
> > -- I think if there is another Kernel client that is trying to release
> that is not owned by
> > it then that Kernel client itself is buggy and needs to be fixed. Please
> share your
> > thoughts on how we can ensure that we can add some protection.
> 
> [Yogesh Marathe] I agree the client has to be fixed but at least the
> client should get some error message instead of crashing someone else. I
> think if hwspinlock_request() and hwspinlock_request_specific() can keep
> the owner info (say thread id) in some module state structure it is
> possible to verify against it before acquiring and releasing the lock

-- I agree with Benoit's point. We don't have to complicate this basic IP block by adding additional checks. 
I2C Kernel module is one of the client and I am not sure if you can rely on thread id for ownership. 

> 
> >
> >
> > >
> > > > > +
> > > > > +     pm_runtime_put(&handle->pdev->dev);
> > > > > +
> > > > > +     return 0;
> >
> > Thank you,
> > Best regards,
> > Hari
