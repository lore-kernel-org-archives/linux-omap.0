From: Jon Loeliger <loeliger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early BRESP
Date: Thu, 1 May 2014 11:18:45 -0500
Message-ID: <CAJgR-BiGjp9G=E7SzgidyVLTjpQ3ETFTFwxDapVc28PyokGa=g@mail.gmail.com>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
	<E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
	<20140429000224.GA31083@verge.net.au>
	<20140429002140.GP27282@n2100.arm.linux.org.uk>
	<20140501151236.078E3C409DA@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140501151236.078E3C409DA-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

I emphatically second Grant's opinion here:
This is a good patch series and is a much-needed improvement.

I am in the middle of a board-port for an A9 system, and this
series will greatly simplify things for me *despite* the fact that
I will need to convert to the new write_sec() form of L2C control
on PSCI-enabled non-secure platforms.

To reiterate Grant's request, please re-consider applying
this L2C patch series!

Thank you,
jdl


On Thu, May 1, 2014 at 10:12 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Tue, 29 Apr 2014 01:21:41 +0100, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>> On Tue, Apr 29, 2014 at 09:02:27AM +0900, Simon Horman wrote:
>> > On Mon, Apr 28, 2014 at 08:30:32PM +0100, Russell King wrote:
>> > > Since we now automatically enable early BRESP in core L2C-310 code when
>> > > we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
>> > > explicitly.  Instead, they should seek to preserve the value of bit 30
>> > > in the auxiliary control register.
>> > >
>> > > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> > > Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>> >
>> > I would prefer if this patch was broken out into individual patches
>> > for each board or SoC file and that they were then picked up
>> > by their respective platform maintainers.
>> >
>> > Likewise for patch 66/97. Although it is only for shmobile
>> > I would prefer it broken out.
>>
>> Oh fuck that.
>>
>> Okay, I'm dropping the whole patch set right now and forgetting the whole
>> damned thing.  The L2 cache code can damned well stay as it is and remain
>> an unmaintainable mess.
>
> FWIW, there are an awful lot of people, myself included, who do care
> that you've done this work. It is 100% okay for you to say "no" to
> requests to split things up because of the complexity of the series.
>
> I really hope you're reconsider and not give up on this series.
>
> g.
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
