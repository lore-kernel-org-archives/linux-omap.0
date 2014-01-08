From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] driver-core: platform: Resolve DT interrupt references
 late
Date: Wed, 8 Jan 2014 13:43:54 -0800
Message-ID: <20140108214354.GG31323@atomide.com>
References: <20140108011957.GK5074@atomide.com>
 <1389185477-507-1-git-send-email-treding@nvidia.com>
 <20140108164040.GA31686@atomide.com>
 <20140108192830.GA1298@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140108192830.GA1298@ulmo.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@gmail.com> [140108 11:32]:
> On Wed, Jan 08, 2014 at 08:40:41AM -0800, Tony Lindgren wrote:
> > 
> > There's nothing wrong with the interrupt related code paths, we're just
> > trying to call the functions at a wrong time when thing are not yet
> > initialized.
> 
> The patch won't get rid of that warning, but it should at least restore
> things to a working state at runtime. At least for well-behaved drivers
> that use platform_get_irq() rather than those that try to access the
> resources directly.

Well the problem I'm seeing is these nasty warnings.

BTW, I think the issue you're talking about regarding platform_get_irq()
got fixed by 4a43d686fe33 (of/irq: Pass trigger type in IRQ resource flags).
 
> > Below is a repost of what works for me without using notifiers. Anybody
> > got any better ideas for a minimal fix?
> 
> That patch is somewhat big for something that should be a minimal fix.
> Being the size that it is it might have undesired side-effects that may
> not get noticed until it's way too late, so I'm hesitant to have
> something like this merged at this point in the release cycle.

Yes I agree it's rather invasive, but we also do have things pretty
badly broken in the kernel for device tree based booting. And it seems
that nobody has a smaller patch that would fix it.

Regards,

Tony
