From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
Date: Tue, 7 Jul 2015 13:11:28 +0200
Message-ID: <CAJZ5v0jRaoTzLbCpgLoag0BvcQWCMc+Do9M=ajkM6+sGJRVE7A@mail.gmail.com>
References: <1436205678-31640-1-git-send-email-balbi@ti.com>
	<2783932.o7RC7vMDHB@vostro.rjw.lan>
	<20150707074053.GO10705@atomide.com>
	<20150707081120.GA15545@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150707081120.GA15545@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 7, 2015 at 10:11 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Jul 07, 2015 at 12:40:53AM -0700, Tony Lindgren wrote:
>> * Rafael J. Wysocki <rjw@rjwysocki.net> [150706 15:49]:
>> > On Monday, July 06, 2015 01:01:18 PM Felipe Balbi wrote:
>> > > on a first call to dev_pm_attach_wake_irq(), if it
>> > > fails, it will leave dev->power.wakeirq set to a
>> > > dangling pointer. Instead, let's clear it to make
>> > > sure a subsequent call to dev_pm_attach_wake_irq()
>> > > has chance to succeed.
>> > >
>> > > Cc: Tony Lindgren <tmlind@atomide.com>
>> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > > ---
>> > >  drivers/base/power/wakeirq.c | 9 ++++++++-
>> > >  1 file changed, 8 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
>> > > index 7470004ca810..394d250a1ad8 100644
>> > > --- a/drivers/base/power/wakeirq.c
>> > > +++ b/drivers/base/power/wakeirq.c
>> > > @@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *dev, int irq,
>> > >
>> > >   err = device_wakeup_attach_irq(dev, wirq);
>> > >   if (err)
>> > > -         return err;
>> > > +         goto err_cleanup;
>> > >
>> > >   return 0;
>> > > +
>> > > +err_cleanup:
>> > > + spin_lock_irqsave(&dev->power.lock, flags);
>> > > + dev->power.wakeirq = NULL;
>> > > + spin_unlock_irqrestore(&dev->power.lock, flags);
>> > > +
>> > > + return err;
>> > >  }
>> >
>> > Too many labels for me and the fact that acquiring of the lock again in the error
>> > patch doesn't look good.
>> >
>> > However, we can do the entire device_wakeup_attach_irq() under the lock (after
>> > removing the locking from it), because we're its only caller.
>> >
>> > So what about the below instead (build-tested only)?
>>
>> Nice, still works for me and simplifies things:
>>
>> Tested-by: Tony Lindgren <tony@atomide.com>
>
> Cool, thanks for testing Tony. Rafael, I'm fine with your version too.
> FWIW:
>
> Reported-by: Felipe Balbi <balbi@ti.com>

OK, applied.

Thanks,
Rafael
