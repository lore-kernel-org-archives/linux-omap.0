From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: gpmc: make gpmc_cs_get_name() static
Date: Mon, 2 Feb 2015 09:07:51 -0800
Message-ID: <20150202170751.GC9418@atomide.com>
References: <1422131320-1018-1-git-send-email-semen.protsenko@globallogic.com>
 <1422131320-1018-2-git-send-email-semen.protsenko@globallogic.com>
 <54C606D8.4080904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54C606D8.4080904@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Semen Protsenko <semen.protsenko@globallogic.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150126 01:23]:
> On 24/01/15 22:28, Semen Protsenko wrote:
> > Fix sparse warning:
> >   warning: symbol 'gpmc_cs_get_name' was not declared. Should it be static?
> > 
> > Signed-off-by: Semen Protsenko <semen.protsenko@globallogic.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Roger is going to queue this, so:

Acked-by: Tony Lindgren <tony@atomide.com>
