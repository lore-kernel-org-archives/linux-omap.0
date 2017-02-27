From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [WARNING: A/V UNSCANNABLE][Merge tag 'media/v4.11-1' of git]
 ff58d005cd: BUG: unable to handle kernel NULL pointer dereference at 0000039c
Date: Mon, 27 Feb 2017 11:23:21 -0800
Message-ID: <CA+55aFxwtkOs95R-v7z8yjguvp91oDTxRKs-x3uN_=sM_33Gvg@mail.gmail.com>
References: <58b07b30.9XFLj9Hhl7F6HMc2%fengguang.wu@intel.com>
 <CA+55aFytXj+TZ_TanbxcY0KgRTrV7Vvr=fWON8tioUGmYHYiNA@mail.gmail.com>
 <20170225090741.GA20463@gmail.com>
 <CA+55aFy+ER8cYV02eZsKAOLnZBWY96zNWqUFWSWT1+3sZD4XnQ@mail.gmail.com>
 <alpine.DEB.2.20.1702271105090.4732@nanos>
 <alpine.DEB.2.20.1702271231410.4732@nanos>
 <20170227154124.GA20569@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170227154124.GA20569-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ruslan Ruslichenko <rruslich-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Sean Young <sean-hENCXIMQXOg@public.gmane.org>, wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, kernel test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKP <lkp-JC7UmRfGjtg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 27, 2017 at 7:41 AM, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> BTW., instead of trying to avoid the scenario, wow about moving in the other
> direction: making CONFIG_DEBUG_SHIRQ=y unconditional property in the IRQ core code
> starting from v4.12 or so

The problem is that it's generally almost undebuggable ahead of time
by developers, and most users won't be able to do good reports either,
because the symptom is geberally a boot-time crash, often with no
logs.

So this option is *not* good for actual users. It's been tried before.

It's a wonderful thing for developers to run with to make sure the
drivers they are working on are resilient to this problem, but we have
too many legacy drivers and lots of random users, and it's unrealistic
to expect them to handle it.

In other words: what will happen is that distros start getting bootup
problem reports six months or a year after we've done it, and *if*
they figure out it's the irq enabling, they'll disable it, because
they have no way to solve it either.

And core developers will just maybe see the occasional "4.12 doesn't
boot for me" reports, but by then developers will ahve moved on to
4.16 or something.

So I don't disagree that in a perfect world all drivers should just
handle it. It's just that it's not realistic.

The fact that we have now *twice* gotten an oops report or a "this
machine doesn't boot" report etc within a week or so of merging the
problematic patch does *not* indicate that it's easy to fix or rare.

Quite the reverse.

It indicates that it's just rare enough that core developers don't see
it, but it's common enough to have triggered issues in random places.

And it will just get *much* worse when you then get the random
end-users that usually have older machines than the developers who
actually test daily development -git trees.

Then we'll just hit *other* random places, and without having testers
that are competent and willing or able to bisect or debug.

                  Linus
