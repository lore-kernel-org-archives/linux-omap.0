From: "Rajendra Nayak" <rnayak@codeaurora.org>
Subject: Re: [RFC 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
Date: Tue, 21 Apr 2015 08:56:49 -0000
Message-ID: <775b18eaf35d4319ae4762098e558d1b.squirrel@www.codeaurora.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
    <7hfv7ue68c.fsf@deeprootsystems.com> <55358AE5.1070900@oracle.com>
    <CAMuHMdX3-Ces57VcpyXEJBSUB07ZtpcCiN8ZpiStGcQnDEHt4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX3-Ces57VcpyXEJBSUB07ZtpcCiN8ZpiStGcQnDEHt4A@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, Kevin Hilman <khilman@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> On Tue, Apr 21, 2015 at 1:25 AM, santosh shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>> On 4/20/2015 4:21 PM, Kevin Hilman wrote:
>>>
>>> Rajendra Nayak <rnayak@codeaurora.org> writes:
>>>
>>>> Most users of PM clocks do the exact same thing in runtime callbacks.
>>>
>>>
>>> Probably because they were all copied from mach-davinci. ;)
>>>
>> Yep. ;-)
>
> If you're interested in the history, I did some digging last year:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/242352.html
>
>>>> Provide default callbacks and cleanup the existing users
>>>> (keystone/davinci/omap1/sh)
>>>
>>>
>>> Very nice cleanup, Thanks!
>
> Note that the new code always has a dev_pm_domain, while the old code had
> it
> conditionally on CONFIG_PM.

Right, but since USE_PM_CLK_RUNTIME_OPS is actually a nop with
!CONFIG_PM, we don't really need the checks anymore.

>
> I don't think that matters much, as we seem to be having more and more
> systems that rely on CONFIG_PM=y...
>
>>> For the series:
>>>
>>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>>>
>> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>
> Looks good to me, and works fine on (pre-Clock Domain) r8a7791/koelsch
> and r8a7740/armadillo-legacy (with PM Domains, but still relying on the
> drivers/sh/pm_runtime.c hack for devices in the C5 "always on" domain).
>
> This code is no longer used in multiplatform kernels on shmobile boards
> with real PM Domains.
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks,
Rajendra

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
