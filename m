From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
Date: Fri, 8 Nov 2019 12:51:39 -0800
Message-ID: <20191108205139.GP5610@atomide.com>
References: <20191007220540.30690-1-aford173@gmail.com>
 <20191022162223.GU5610@atomide.com>
 <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
 <20191022221919.GF5610@atomide.com>
 <1CE62E4E-1A38-448C-9197-8FA16747F942@goldelico.com>
 <20191023143646.GG5610@atomide.com>
 <CAHCN7xKi4oSoVbRM=-D1s2GnMig8xs6iYNwUWj2Ohfj+1okx=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xKi4oSoVbRM=-D1s2GnMig8xs6iYNwUWj2Ohfj+1okx=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191108 20:03]:
> On Wed, Oct 23, 2019 at 9:36 AM Tony Lindgren <tony@atomide.com> wrote:
> > My guess is we need to call clk_disable() and call
> > ti_bandgap_save_ctxt() on CPU_CLUSTER_PM_ENTER similar to
> > what ti_bandgap_suspend does. And then restore it on
> > CPU_CLUSTER_PM_EXIT.
> >
> > There's a similar example already in gpio_omap_cpu_notifier().
> > Not sure if there is some related errata to deal with too,
> > probably the old Nokia n900 or n9 would provide some hints
> > on what exactly needs to be done.
> 
> I 'think' I have a patch ready that does what you're asking, but I
> will fully admit that I don't completely grasp what's going on.
> 
> I'll submit it as an RFC, but I am not even sure I understand what to
> put into the description, so if you're OK with reviewing the RFC, feel
> free to mark up the actual commit message as well.
> 
> From what I can see, the changes haven't negatively impact stuff. I
> didn't see the power consumption go up before, so I am not sure I can
> replicate your findings.
> 
> It'll be posted shortly.

Yeah seems to do the job, thanks for fixing this issue.

Tony
