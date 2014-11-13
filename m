From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
Date: Thu, 13 Nov 2014 21:45:09 +0200
Message-ID: <CAK=WgbbodS8GsUxQbkyCp6hAG+Ko4LMirx+pUa8_fUdxWFasvw@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
 <1410553499-55951-5-git-send-email-s-anna@ti.com> <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
 <5463B5B6.8040709@ti.com> <CAK=WgbbatPTiz3efDWHVEcuug_UQfkCViMoK0zcfUg3JwB2oTA@mail.gmail.com>
 <5464EC7A.7050603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5464EC7A.7050603-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Thu, Nov 13, 2014 at 7:38 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> No, not always, because, either of them can be optional between
> different platform implementations. For example, on OMAP, the number of
> locks is read from an IP register, and not coded in DT. Similarly,
> base_id can be optional on SoCs that don't have multiple IP instances.

It can, but base_id isn't optional today --- it must be provided via
platform_data --- and I'm not sure we should implicitly change this
semantics while moving to DT. We never guessed the base_id before,
even if there was only a single IP instance, and I'm not convinced we
should start doing it now.

About the number of locks - why do we even need it at this point? the
global lock id should just be base_id + the lock index.

> IMHO, this life cycle management is not that complicated

It's always very easy to add code, really. It is never complicated.
But then gradually the code becomes harder to maintain, debug, and
change.

On the contrary, achieving the same functionality with less code is
always harder. But when we get there, the results are pretty
satisfying.

In this case I still feel the extra linked list is redundant.

Please try it: ditch the "hwspinlock/core: maintain a list of
registered hwspinlock banks" patch, and replace of_hwspin_lock_get_id
with a slim method that just returns the base_id + the lock index. Let
me know if it works for you.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
