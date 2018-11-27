From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Tue, 27 Nov 2018 10:03:18 -0800
Message-ID: <20181127180318.GT53235@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <20181126101434.GB10878@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126101434.GB10878@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

* Thierry Reding <treding@nvidia.com> [181126 10:14]:
> I'm not sure we need to go to those lengths. As far as I'm concerned, if
> it turns out that we've inverted the logic for Tegra114, that's a bug in
> the DTS and we should fix it along with the driver to remove the double
> negation. I don't think this would be causing any problems with existing
> DTBs since, as far as I can tell, the TPS65913 is only used on Dalmore
> (which was never publicly available) or Roth and TN7, neither of which I
> think anyone ever ran upstream Linux on other than maybe Alex who added
> the support. In all of the above cases, there is no problem updating the
> DTB since it's all loaded either from eMMC or from an Android boot image
> as far as I understand.

As Jon explained, Tegra PMC inverts the Palmas interrupt twice, so it
gets inverted total three times. So no need to do anything right now,
I'll just change the omap5 PMIC interrupt to use a GPIO instead like
dra7 is already doing.

Thanks everybody for checking the use on Tegra.

Regards,

Tony
