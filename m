From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 5/5] hwspinlock/omap: add support for dt nodes
Date: Wed, 12 Nov 2014 13:50:15 -0600
Message-ID: <5463B9F7.8040105@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-6-git-send-email-s-anna@ti.com> <CAK=WgbZE7_WrsNz5E+MDX7j2tAGEjv91zeCgqhB=Jsiu0+d8vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbZE7_WrsNz5E+MDX7j2tAGEjv91zeCgqhB=Jsiu0+d8vw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 11/12/2014 01:14 PM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>>  static int omap_hwspinlock_probe(struct platform_device *pdev)
>>  {
>> -       struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
>> +       struct device_node *node = pdev->dev.of_node;
>>         struct hwspinlock_device *bank;
>>         struct hwspinlock *hwlock;
>>         struct resource *res;
>>         void __iomem *io_base;
>> -       int num_locks, i, ret;
>> +       int num_locks, i, ret, base_id;
>>
>> -       if (!pdata)
>> +       if (!node)
>>                 return -ENODEV;
>>
>> +       ret = of_hwspin_lock_get_base_id(node);
>> +       if (ret < 0 && ret != -EINVAL)
>> +               return -ENODEV;
>> +       base_id = (ret > 0 ? ret : 0);
> 
> Does this mean you allow nodes not to have the base_id property? How
> do we protect against multiple nodes not having a base_id property
> then?
> 
> Implicitly assuming a base_id value (zero in this case) may not be always safe.

None of the OMAPs have multiple IP instances, and as such the base-id is
an optional property. I have made this change to make sure we atleast
attempt to use the value if mentioned in DT and not hard-coding the
value to begin with (going by the optional property semantics). If and
when multiple instances get added and a secondary node doesn't add the
property, the node will not be registered with the core due to an
overlap failure. Here is the previous version [1] for reference.

regards
Suman

[1] https://patchwork.kernel.org/patch/4096881/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
