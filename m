From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Mon, 30 Jan 2017 16:01:26 -0800
Message-ID: <CAKvHMgRuX7eELjixu8_WaGiaQbh_S7am=yzfrYuyUe7rGchC1w@mail.gmail.com>
References: <20170120220440.1971-1-tony@atomide.com> <20170120220440.1971-3-tony@atomide.com>
 <CAKvHMgQKPZcdBPMUH-3_e-M4sHPijEH59019bygmi+o2y4B+Rw@mail.gmail.com>
 <20170124012702.GA7403@atomide.com> <CAKvHMgTvdEz=YRxB-sd-FHws+DH9DJTnVst3Tc=9HoaKMq--Ow@mail.gmail.com>
 <20170124182925.GF7403@atomide.com> <CAKvHMgSs-2Rg8sL5o9cfv1UuWWxfQ+g_O4y07JuMtU3f3UGfMQ@mail.gmail.com>
 <20170130235558.GZ7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170130235558.GZ7403@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2017 at 3:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Liam Breck <liam@networkimprov.net> [170126 15:57]:
>> On Tue, Jan 24, 2017 at 10:29 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > @@ -1430,10 +1473,20 @@ static int bq24190_probe(struct i2c_client *client,
>> >  static int bq24190_remove(struct i2c_client *client)
>> >  {
>> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
>> > +       int error;
>> > +
>> > +       error = pm_runtime_get_sync(bdi->dev);
>> > +       if (error < 0) {
>> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
>> > +               pm_runtime_put_noidle(bdi->dev);
>> > +       }
>> >
>> > -       pm_runtime_get_sync(bdi->dev);
>> >         bq24190_register_reset(bdi);
>> > -       pm_runtime_put_sync(bdi->dev);
>> > +
>> > +       if (!error) {
>> > +               pm_runtime_dont_use_autosuspend(bdi->dev);
>> > +               pm_runtime_put_sync(bdi->dev);
>> > +       }
>>
>> Should put_sync() be called before dont_use_autosuspend(), as in probe()?
>
> Yeah good to have them paired. With pm_runtime_put_noidle() we're
> active on error, so we can just call pm_runtime_dont_use_autosuspend()
> and pm_runtime_put_sync() unconditionally.

I meant should the two pm_runtime_* calls above be flipped, so
put_sync() is first. That's the order in probe()
