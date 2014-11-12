From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
Date: Wed, 12 Nov 2014 21:08:22 +0200
Message-ID: <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-5-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410553499-55951-5-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> +int of_hwspin_lock_get_id(struct device_node *np, int index)
> +{
> +       struct hwspinlock_device *bank;
> +       struct of_phandle_args args;
> +       int id;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_args(np, "hwlocks", "#hwlock-cells", index,
> +                                        &args);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&hwspinlock_tree_lock);
> +       list_for_each_entry(bank, &hwspinlock_devices, list)
> +               if (bank->dev->of_node == args.np)
> +                       break;
> +       mutex_unlock(&hwspinlock_tree_lock);
> +       if (&bank->list == &hwspinlock_devices) {
> +               ret = -EPROBE_DEFER;
> +               goto out;
> +       }

Is this the validation you mentioned which requires the existence of
"hwspinlock/core: maintain a list of registered hwspinlock banks" ?

I'm not convinced this is needed for several reasons:
- the user isn't using the lock yet at this point, and may only need
the id in order to communicate it to a remote processor
- if the user will try to use the lock prematurely,
hwspin_lock_request_specific should stop her
- moreover, hwspin_lock_request_specific must be the one who validates
the id, since in heterogeneous systems the user may get the id from a
remote processor and not via of_hwspin_lock_get_id

 "hwspinlock/core: maintain a list of registered hwspinlock banks"
adds complexity which must be very strongly justified.

If we're not sure there is a strong justification for it, we better
not merge it.

> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_base_id);
...
> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_num_locks);

Do we really must expose these two helpers globally?

Can we instead make these "static inline" methods and embed them in
hwspinlock_internal.h ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
