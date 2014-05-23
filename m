From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 00/16] OMAP: GPMC: Restructure OMAP GPMC driver
 (NAND) : DT binding change proposal
Date: Fri, 23 May 2014 07:53:55 -0700
Message-ID: <20140523145354.GE2321@atomide.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
 <20140521160818.GA1150@arch.cereza>
 <537DB17A.6060608@ti.com>
 <CABxcv=nbgGhVN+XYO8s=mYOpoLU9-kWuEqc+FLMaSbWS7BJNyQ@mail.gmail.com>
 <20140522144600.GA1785@arch.cereza>
 <537F03C8.3070101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <537F03C8.3070101@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Brian Norris <computersforpeace@gmail.com>, "Gupta, Pekon" <pekon@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Jingoo Han <jg1.han@samsung.com>, dwmw2@infradead.org, nsekhar@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140523 01:17]:
> On 05/22/2014 05:46 PM, Ezequiel Garcia wrote:
> > On 22 May 01:51 PM, Javier Martinez Canillas wrote:
> >> On Thu, May 22, 2014 at 10:12 AM, Roger Quadros <rogerq@ti.com> wrote:
> >>>> On 21 May 02:20 PM, Roger Quadros wrote:
> >>>> While I agree that the GPMC driver is a bit messy, I'm not sure it's possible
> >>>> to go through such a complete devicetree binding re-design (breaking backwards
> >>>> compatibility) now that the binding is already in production.
> >>>
> >>> Why not? especially if the existing bindings are poorly dones. Is anyone using these
> >>> bindings burning the DT into ROM and can't change it when they update the kernel?
> >>>
> >>
> >> While I do agree that your DT bindings are much better than the
> >> current ones, there is a policy that DT bindings are an external API
> >> and once are released with a kernel are set in stone and can't be
> >> changed.
> >>
> > 
> > Exactly. The DT binding is considered an ABI. Thus, invariant across kernel
> > versions. Users can't be coherced into a DTB update after a kernel update.
> > 
> > That said, I don't really care if you break compatilibity in this case.
> > Rather, I'm suggesting that you make sure this change is going to be accepted
> > upstream, before doing any more work. The DT maintainers are reluctant to do
> > so.
> 
> Appreciate your concern.
> 
> Would be really nice if you can review patches 1-12. They have nothing to do with DT changes.
> Thanks.

I'm mostly concerned about keeping things working. I think the
only way we can keep things working is to keep support for
the old binding around in addition to the new one. That way
we can update devices one at a time.

Regards,

Tony
