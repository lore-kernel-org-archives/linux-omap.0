From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Tue, 7 Feb 2017 10:20:46 -0800
Message-ID: <CAKvHMgRxONjiyn2Zg-f3s0m8KAYR3vK5G3aD4WkJWjA32GsBaA@mail.gmail.com>
References: <20170131000210.5442-1-tony@atomide.com> <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
 <20170131003632.GB7403@atomide.com> <CAKvHMgTOKoeOxp0oxOBOO7zqothPWeC9aBrV-Km1Rq+YAafw5w@mail.gmail.com>
 <20170203185408.GB3721@atomide.com> <CAKvHMgQs3YYtyMApYvdRAyzuzii_xA=ZKRfqG-zpFzrMef_qdg@mail.gmail.com>
 <20170203211707.GC3721@atomide.com> <CAKvHMgRV=mm2XBtrNjQCvGXuAQY6n6xEKerP4eVw2izkS9C7ww@mail.gmail.com>
 <20170207160157.GA21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170207160157.GA21809@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 7, 2017 at 8:01 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Liam Breck <liam@networkimprov.net> [170203 16:25]:
>> On Fri, Feb 3, 2017 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >  static int bq24190_remove(struct i2c_client *client)
>> >  {
>> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
>> > +       int error;
>> >
>> > -       pm_runtime_get_sync(bdi->dev);
>> > -       bq24190_register_reset(bdi);
>> > -       pm_runtime_put_sync(bdi->dev);
>> > +       error = pm_runtime_get_sync(bdi->dev);
>> > +       if (error < 0) {
>> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
>> > +               pm_runtime_put_noidle(bdi->dev);
>> > +       }
>> >
>> > +       bq24190_register_reset(bdi);
>> >         bq24190_sysfs_remove_group(bdi);
>> >         power_supply_unregister(bdi->battery);
>> >         power_supply_unregister(bdi->charger);
>> > +       pm_runtime_put_sync(bdi->dev);
>> > +       pm_runtime_dont_use_autosuspend(bdi->dev);
>> >         pm_runtime_disable(bdi->dev);
>>
>> I think you addressed this, but should the above be
>>
>> if (!error)
>>   pm_runtime_put_sync(bdi->dev);
>
> Hmm yeah.. But we need to check for if (error >= 0), also in the other
> places see below.

OK, let's roll v4. it is

Acked-by: Liam Breck <kernel@networkimprov.net>

(and pls include the v4 in all subjects :-)

I have a patchset for DT support in the works which depends on this one.
