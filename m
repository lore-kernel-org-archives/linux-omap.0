From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/13] video: omap: allow building on !MMU
Date: Thu, 8 May 2014 14:53:38 -0700
Message-ID: <20140508215338.GE2198@atomide.com>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
 <1398342509-10243-14-git-send-email-peter.griffin@linaro.org>
 <5369F973.10803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5369F973.10803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 02:15]:
> On 24/04/14 15:28, Peter Griffin wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The omap lcdc driver has an elaborate mmap_kern function
> > to map the frame buffer into kernel address space as
> > write-combined. This uses functions that are only available
> > on MMU-enabled builds.
> > 
> > It does seem equivalent to ioremap_wc though, so we should
> > be able to just use that instead.
> > 
> > This patch is build-tested only, it needs to be run on real
> > hardware before applying.
> 
> I don't have omap1 boards, and I don't know anyone that has. I don't
> even know if the omap1 fb is working or not...
> 
> Tony, any idea of omap1's fb? Are you able to test this?

I have three omap1 boards in my rack that I use for my boot
testing. Tried to enable framebuffer but so far no luck on
any of them. So I'm not much of a help here. Looks like the
patch should work though..

Aaro & Janusz, care to take a look at the patch in this
thread?

Regards,

Tony
