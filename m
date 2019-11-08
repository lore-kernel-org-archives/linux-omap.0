From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
Date: Fri, 8 Nov 2019 15:04:12 -0600
Message-ID: <CAHCN7xLv9K07ya4Ssj_zs_7pwGwWVT_P4QbH88Bz0wPjB=HX_A@mail.gmail.com>
References: <20191007220540.30690-1-aford173@gmail.com> <20191022162223.GU5610@atomide.com>
 <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
 <20191022221919.GF5610@atomide.com> <1CE62E4E-1A38-448C-9197-8FA16747F942@goldelico.com>
 <20191023143646.GG5610@atomide.com> <CAHCN7xKi4oSoVbRM=-D1s2GnMig8xs6iYNwUWj2Ohfj+1okx=Q@mail.gmail.com>
 <20191108205139.GP5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108205139.GP5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 8, 2019 at 2:51 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191108 20:03]:
> > On Wed, Oct 23, 2019 at 9:36 AM Tony Lindgren <tony@atomide.com> wrote:
> > > My guess is we need to call clk_disable() and call
> > > ti_bandgap_save_ctxt() on CPU_CLUSTER_PM_ENTER similar to
> > > what ti_bandgap_suspend does. And then restore it on
> > > CPU_CLUSTER_PM_EXIT.
> > >
> > > There's a similar example already in gpio_omap_cpu_notifier().
> > > Not sure if there is some related errata to deal with too,
> > > probably the old Nokia n900 or n9 would provide some hints
> > > on what exactly needs to be done.
> >
> > I 'think' I have a patch ready that does what you're asking, but I
> > will fully admit that I don't completely grasp what's going on.
> >
> > I'll submit it as an RFC, but I am not even sure I understand what to
> > put into the description, so if you're OK with reviewing the RFC, feel
> > free to mark up the actual commit message as well.
> >
> > From what I can see, the changes haven't negatively impact stuff. I
> > didn't see the power consumption go up before, so I am not sure I can
> > replicate your findings.
> >
> > It'll be posted shortly.
>
> Yeah seems to do the job, thanks for fixing this issue.

I am glad I could help!  I am learning new stuff.  :-)

Once the other patch to fix the bandgap clock idling, will it be
possible to accept this as-is, or do you need me to re-base and submit
again?

Ideally, once we get the thermal stuff in and we can drop Nikolaus'
turbo option on the 1GHz processor and just let the processor scale to
1GHz without having to deal with the boost stuff since it should
throttle back when the junction temp hits its threshold.

If you want me to re-base, please let me know which branch I should use.

Thank you,

adam

>
> Tony
