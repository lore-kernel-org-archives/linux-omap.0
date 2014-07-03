From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv5 03/15] hwspinlock/core: maintain a list of registered
 hwspinlock banks
Date: Thu, 3 Jul 2014 12:28:46 -0500
Message-ID: <53B592CE.2010001@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com> <1398904476-26200-4-git-send-email-s-anna@ti.com> <CAK=WgbakGbTaYz+4K24aT3vyRkDYwPKCm6XrcJvH667NMMfTTA@mail.gmail.com> <53B47621.6090307@ti.com> <CAK=WgbYtJ7TGqvjG3VAPPD5tVXx9-jEJU3iKEStUMxOvD1v=LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbYtJ7TGqvjG3VAPPD5tVXx9-jEJU3iKEStUMxOvD1v=LQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 07/03/2014 02:00 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, Jul 3, 2014 at 12:14 AM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>>> I'm not sure we need this patch.
>>
>> This patch is needed if we use the controller-phandle + args specifier
>> for requesting hwlocks by a client, as we need to translate
>> controller-phandle to the corresponding hwspinlock_device.
>>
>> Looks like we still don't have a closure on the semantics of how
>> clients have to request a lock in DT. You are suggesting something like
>>     hwlocks = <global_lock1 global_lock2 ...>;
>>
>> whereas this patch is built to support based on comments from
>> DT-maintainers,
>>     hwlocks = <controller-phandle lock-specifier1>, <controller-phandle
>> lock-specifier2>...;
> 
> I'm actually ok with this suggestion and haven't suggested otherwise.

OK, thanks for confirming and sorry for the misinterpretation.

> 
> All I propose is that we add the base_id property to the controller
> node (as you have done in the subsequent patches), and then drivers
> will be able to infer the global lock id from the DT data by adding
> the controller's base_id to the lock specifier.

OK, but we would still require this function to lookup the registered
device from the controller-phandle to retrieve the base_id. Do note that
the hwspinlock core currently only maintains the registered locks in an
integrated radix tree, but not the registered hwspinlock banks themselves.

regards
Suman

> Controllers with non standard lock indexing may use an xlate() method
> if needed but frankly this is fictional right now. We can start
> without this, and add it later when needed, as this doesn't affect the
> DT data.
> 
> With the global lock id in hand, drivers could simply use the existing
> hwspin_lock_request_specific API to obtain a specific lock, and then
> we don't need this patch.
> 
> Thanks,
> Ohad.
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
