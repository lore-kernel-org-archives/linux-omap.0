From: Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH RESEND 3/3] hwspinlock: omap: Use devm_hwspin_lock_register()
 to register hwlock controller
Date: Sat, 25 Jan 2020 12:10:26 +0800
Message-ID: <CADBw62okdejAcXcT23gUL4qLLFo5YhzisF8uSdoOOheoqv09-A@mail.gmail.com>
References: <cover.1578453062.git.baolin.wang7@gmail.com> <315adcc5dfc6aa5c001448401dda4065e33deef2.1578453062.git.baolin.wang7@gmail.com>
 <20200122001515.GA14744@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34616 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgAYEKj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2020 23:10:39 -0500
In-Reply-To: <20200122001515.GA14744@builder>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ohad Ben Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Bjorn,

On Wed, Jan 22, 2020 at 8:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 07 Jan 19:14 PST 2020, Baolin Wang wrote:
>
> > Use devm_hwspin_lock_register() to register the hwlock controller instead of
> > unregistering the hwlock controller explicitly when removing the device.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/hwspinlock/omap_hwspinlock.c |   13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> > index 3b05560..9e8a8c2 100644
> > --- a/drivers/hwspinlock/omap_hwspinlock.c
> > +++ b/drivers/hwspinlock/omap_hwspinlock.c
> > @@ -131,8 +131,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
> >       for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
> >               hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
> >
> > -     ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
> > -                                             base_id, num_locks);
> > +     ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
> > +                                     base_id, num_locks);
> >       if (ret)
> >               goto runtime_err;
> >
> > @@ -148,15 +148,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
> >
> >  static int omap_hwspinlock_remove(struct platform_device *pdev)
> >  {
> > -     struct hwspinlock_device *bank = platform_get_drvdata(pdev);
> > -     int ret;
> > -
> > -     ret = hwspin_lock_unregister(bank);
> > -     if (ret) {
> > -             dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
> > -             return ret;
> > -     }
> > -
>
> Relying on devm_hwspin_lock_register() to hwspin_lock_unregister() will
> mean that pm_runtime_disable() will now be called before the spinlocks
> are unregistered.

Yes, you are right. Thanks for catching this issue.
