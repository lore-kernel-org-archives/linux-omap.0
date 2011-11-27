From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/5] common clk framework
Date: Sat, 26 Nov 2011 17:12:47 -0800
Message-ID: <CAJOA=zMGaXLrC=sLzrZKTqAKqQHpmn9=xx94ucaCsFAZ6EfYqw@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<20111126070601.GA19176@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20111126070601.GA19176-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 25, 2011 at 11:06 PM, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> On Mon, Nov 21, 2011 at 05:40:42PM -0800, Mike Turquette wrote:
>> =A0 .speaking of which, clk_set_rate has been overhauled and is now
>> recursive. *collective groan*. =A0clk_set_rate is still simple for the
>> common case of simply setting a single clk's rate. =A0But if your clk has
>> the CLK_PARENT_SET_RATE flag and the .round_rate callback recommends
>> changing the parent rate, then clk_set_rate will recurse upwards to the
>> parent and try it all over again. =A0In the event of a failure everything
>> unwinds and all the clks go out for drinks.
>>
> I smell that this will be the part which makes the whole series risky
> of being accepted in a desired time frame, with saying rate change
> notifications are still missing for now.

I agree.  I'll send out V4 this coming week with the clk rate change
notifiers rolled in.  That means that there won't be any missing
pieces for my vision of how a complex clk tree should interact with
drivers.  If it is not what people want then we can probably de-scope
pieces of it, but I think the architecture is sound.

Thanks for reviewing Shawn.

Regards,
Mike
