From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU
 bootup
Date: Thu, 02 Dec 2010 17:55:15 +0000
Message-ID: <1291312515.25722.8.camel@e102109-lin.cambridge.arm.com>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	 <20101130171658.GA24034@oksana.dev.rtsoft.ru>
	 <20101130233204.GB14383@n2100.arm.linux.org.uk>
	 <20101201002527.GC14383@n2100.arm.linux.org.uk>
	 <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
	 <20101202152428.GD10461@n2100.arm.linux.org.uk>
	 <1291307320.11271.51.camel@e102109-lin.cambridge.arm.com>
	 <20101202173824.GE10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20101202173824.GE10461@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>, Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Jamie Iles <jamie.iles@picochip.com>, Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-12-02 at 17:38 +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 02, 2010 at 04:28:40PM +0000, Catalin Marinas wrote:
> > The SCU is part of the core TRM, so I don't expect it to be the same
> > across various MP cores (and A15 is an example).
> >
> > You may want to consolidate functions like scu_prepare_cpus (maybe call
> > it smp_prepare_cpus)
> 
> You do realise the function called from architecture independent code is
> called 'smp_prepare_cpus' ?

It indeed looked familiar when I wrote it down :)

> BTW, is it worth making sure that the IC and SCU standby mode bits
> are set for A9 MPCore ?

IMHO I would leave such default settings to the boot monitor as it knows
better whether such feature works or has any benefits. If you want to
always set the bits, it may need trying on a few A9 platforms to make
sure they still work.

-- 
Catalin
