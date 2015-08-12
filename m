From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] memory: omap-gpmc: Don't try to save the GPMC context
Date: Wed, 12 Aug 2015 01:47:20 -0700
Message-ID: <20150812084720.GU4215@atomide.com>
References: <1438777455-28009-1-git-send-email-tomeu.vizoso@collabora.com>
 <CABxcv=mOziw-iiyWO91Bam_hvxjg8mZs1zo=MMP4XjijkDyqmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=mOziw-iiyWO91Bam_hvxjg8mZs1zo=MMP4XjijkDyqmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@dowhile0.org> [150805 05:47]:
> Hello Tomeu,
> 
> On Wed, Aug 5, 2015 at 2:24 PM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> > ...if there isn't one already.
> >
> 
> I think is better to instead splitting the subject line like this, to
> change it for something that fits like "memory: omap-gpmc: Don't try
> to save uninitialized GPMC context"  or "memory: omap-gpmc: Fix
> gpmc_base NULL pointer dereference"

I'll apply this into omap-for-v4.2/fixes-v2 with the description
updated by adding word "unitialized".

Regards,

Tony
