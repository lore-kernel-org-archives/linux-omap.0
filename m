From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
Date: Tue, 7 Jul 2015 06:17:07 +0200
Message-ID: <CAOf5uwkwe0PudVVKGs_6-DNuYDqS=p5EOA4=5uVQSTK0BhinWw@mail.gmail.com>
References: <1436205678-31640-1-git-send-email-balbi@ti.com>
	<CAOf5uwnj=0m99E96k-+AYu68yE_UnX1WVU-=6y7OvJnfXKh8+g@mail.gmail.com>
	<20150706180921.GF20779@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150706180921.GF20779@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, rjw@rjwysocki.net, Tony Lindgren <tmlind@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi

On Mon, Jul 6, 2015 at 8:09 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Jul 06, 2015 at 08:06:17PM +0200, Michael Trimarchi wrote:
>> Hi
>>
>> On Jul 6, 2015 8:01 PM, "Felipe Balbi" <balbi@ti.com> wrote:
>> >
>> > on a first call to dev_pm_attach_wake_irq(), if it
>> > fails, it will leave dev->power.wakeirq set to a
>> > dangling pointer. Instead, let's clear it to make
>> > sure a subsequent call to dev_pm_attach_wake_irq()
>> > has chance to succeed.
>> >
>> > Cc: Tony Lindgren <tmlind@atomide.com>
>> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > ---
>> >  drivers/base/power/wakeirq.c | 9 ++++++++-
>> >  1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
>> > index 7470004ca810..394d250a1ad8 100644
>> > --- a/drivers/base/power/wakeirq.c
>> > +++ b/drivers/base/power/wakeirq.c
>> > @@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *dev,
>> int irq,
>> >
>> >         err = device_wakeup_attach_irq(dev, wirq);
>> >         if (err)
>> > -               return err;
>> > +               goto err_cleanup;
>> >
>> >         return 0;
>> > +
>> > +err_cleanup:
>> > +       spin_lock_irqsave(&dev->power.lock, flags);
>> > +       dev->power.wakeirq = NULL;
>> > +       spin_unlock_irqrestore(&dev->power.lock, flags);
>> > +
>>
>> Why here and not in the fuction that return the error?
>
> because the field was set here, why would I clear it elsewhere ?
>

Clear now and even more from the other patch proposal.

Michael

> --
> balbi



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
