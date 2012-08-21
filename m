From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 4/4] gpio: smscece: Add support for gpio IO
 expander feature
Date: Tue, 21 Aug 2012 15:50:09 +0100
Message-ID: <20120821145009.GE21557@sirena.org.uk>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-5-git-send-email-sourav.poddar@ti.com>
 <20120821105333.GW10347@arwen.pp.htv.fi>
 <CAKdam56DiFpnoQwrHe1tjQWLMy5vP9ynstNj_n=OyMxkJJAUOA@mail.gmail.com>
 <20120821120052.GD10347@arwen.pp.htv.fi>
 <CAKdam55SqXiCGv766yxoY1GdDjxNCYNaDdNZPaeLTAXc+3+c6g@mail.gmail.com>
 <20120821122217.GF10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120821122217.GF10347@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 21, 2012 at 03:22:18PM +0300, Felipe Balbi wrote:
> On Tue, Aug 21, 2012 at 05:50:28PM +0530, Poddar, Sourav wrote:

> > If I am understanding correctly, if they both uses the same bit we cannot
> > use both for a particular user. ?

> we can, it's just a bit more complex. If a user request both LOW and
> HIGH, then you start with HIGH, once it triggers, before calling the
> nested IRQ handler, you need to change it LOW. When low triggers, before
> calling the nested IRQ handler, you need to change it to HIGH again. And
> so on. I'm just not sure if that's valid on linux IRQ subsystem.

The given example was for keypress - usually a system would use edge
triggered interrupts in combination with reading the GPIO state rather
than level triggered interrupts.
