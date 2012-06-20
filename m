From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH v2 2/4] ARM: add flush_mem api for ARMv6
Date: Wed, 20 Jun 2012 14:32:08 +0530
Message-ID: <CADysL2aTMwDW1xXjRcOrEm5Fq2S6+V31yE0AeDCHBw2Ak+sU7Q@mail.gmail.com>
References: <CADysL2acF3ttJ-TR2as+GT66MfJiK4YyWYaAiP5j8yQ+YLBGYQ@mail.gmail.com>
	<20120620084547.GB13009@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120620084547.GB13009@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Russell,


On Wed, Jun 20, 2012 at 2:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Tue, Jun 19, 2012 at 04:51:16PM +0530, Gupta, Ramesh wrote:
> > >From 630a3a8f341eb7f58f9a63bf786d732b5bdfd01e Mon Sep 17 00:00:00 2001
> > From: Ramesh Gupta G <grgupta@ti.com>
> > Date: Fri, 15 Jun 2012 16:39:21 +0530
> > Subject: [PATCH v2 2/4] ARM: add flush_mem api for ARMv6
> >
> > Added flush_mem cache maintenance api for ARMv6.
> > The implementation is based on dma_flush_range.
>
> And what about all the other users of the define_cache_functions macro?

I initially added only for ARMv6/7 and I will add this for the other users.

> This series is incomplete, and therefore entirely unsuitable for
> upstreaming.

I will send an updated patch set.

Thank you for the comments.

Regards
Ramesh Gupta G
