From: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC 1/4] phy: Add provision for tuning phy.
Date: Wed, 11 Dec 2013 12:08:04 +0530
Message-ID: <CAFp+6iENkrSUT=_iv+uZnVpDSGDQGOzF_oyZ6Dmzr8VcQfjztw@mail.gmail.com>
References: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
	<1386672926-26885-2-git-send-email-gautam.vivek@samsung.com>
	<20131210140142.GB28456@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131210140142.GB28456@xps8300>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,


On Tue, Dec 10, 2013 at 7:31 PM, Heikki Krogerus
<heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi,

Thanks for reviewing this.

>
> On Tue, Dec 10, 2013 at 04:25:23PM +0530, Vivek Gautam wrote:
>> Some PHY controllers may need to tune PHY post-initialization,
>> so that the PHY consumers can call phy-tuning at appropriate
>> point of time.
>>
>> Signed-off-by: vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/phy/phy-core.c  |   20 ++++++++++++++++++++
>>  include/linux/phy/phy.h |    7 +++++++
>>  2 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index 03cf8fb..68dbb90 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -239,6 +239,26 @@ out:
>>  }
>>  EXPORT_SYMBOL_GPL(phy_power_off);
>>
>> +int phy_tune(struct phy *phy)
>> +{
>> +     int ret = -ENOTSUPP;
>> +
>> +     mutex_lock(&phy->mutex);
>> +     if (phy->ops->tune) {
>> +             ret =  phy->ops->tune(phy);
>> +             if (ret < 0) {
>> +                     dev_err(&phy->dev, "phy tuning failed --> %d\n", ret);
>> +                     goto out;
>> +             }
>> +     }
>> +
>> +out:
>> +     mutex_unlock(&phy->mutex);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(phy_tune);
>
> I think "setup" instead of "tune" is much more clear and reusable.

I think "setup" will look more like first time setting up the phy,
which is rather served by "init" callback.
This i thought would serve the purpose of over-riding certain PHY
parameters, which would not have been
possible at "init" time.
Please correct my thinking if i am unable to understand your point here.

>
> Thanks,
>
> --
> heikki
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
