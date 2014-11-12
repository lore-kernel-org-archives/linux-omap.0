From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
Date: Wed, 12 Nov 2014 13:32:06 -0600
Message-ID: <5463B5B6.8040709@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-5-git-send-email-s-anna@ti.com> <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

Thanks for the review.

On 11/12/2014 01:08 PM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna@ti.com> wrote:
>> +int of_hwspin_lock_get_id(struct device_node *np, int index)
>> +{
>> +       struct hwspinlock_device *bank;
>> +       struct of_phandle_args args;
>> +       int id;
>> +       int ret;
>> +
>> +       ret = of_parse_phandle_with_args(np, "hwlocks", "#hwlock-cells", index,
>> +                                        &args);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mutex_lock(&hwspinlock_tree_lock);
>> +       list_for_each_entry(bank, &hwspinlock_devices, list)
>> +               if (bank->dev->of_node == args.np)
>> +                       break;
>> +       mutex_unlock(&hwspinlock_tree_lock);
>> +       if (&bank->list == &hwspinlock_devices) {
>> +               ret = -EPROBE_DEFER;
>> +               goto out;
>> +       }
> 
> Is this the validation you mentioned which requires the existence of
> "hwspinlock/core: maintain a list of registered hwspinlock banks" ?

Well, not exactly. The validation is on the following segment,

+	id = of_hwspin_lock_simple_xlate(bank, &args);
+	if (id < 0 || id >= bank->num_locks) {
+		ret = -EINVAL;
+		goto out;
+	}

That said, it is also needed to provide the support for deferred probing
without changing the return code conventions on the existing API.

> 
> I'm not convinced this is needed for several reasons:
> - the user isn't using the lock yet at this point, and may only need
> the id in order to communicate it to a remote processor

Yes, and wouldn't that require that the id is validated? It just cannot
return any return value, and expect it will be verified somewhere else
or in a following API call. Not doing the validation unnecessarily
complicates the system usage of a lock as you are sharing an invalid
lock to a remote processor and then you have two validation failure
paths on different processors.

> - if the user will try to use the lock prematurely,
> hwspin_lock_request_specific should stop her
> - moreover, hwspin_lock_request_specific must be the one who validates
> the id, since in heterogeneous systems the user may get the id from a
> remote processor and not via of_hwspin_lock_get_id
> 
>  "hwspinlock/core: maintain a list of registered hwspinlock banks"
> adds complexity which must be very strongly justified.
> 
> If we're not sure there is a strong justification for it, we better
> not merge it.
> 
>> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_base_id);
> ...
>> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_num_locks);
> 
> Do we really must expose these two helpers globally?
> 
> Can we instead make these "static inline" methods and embed them in
> hwspinlock_internal.h ?

Actually, not a bad idea, I will move it, thanks. All the client drivers
would need it, and they already have to include the internal header.

regards
Suman
