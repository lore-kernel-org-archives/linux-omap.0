From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC-v2 0/7] Capebus; a bus for SoCs using simple expansion
 connectors
Date: Mon, 14 Jan 2013 02:23:27 +0000
Message-ID: <20130114022326.GA4928@sirena.org.uk>
References: <1351783952-11804-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351783952-11804-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 01, 2012 at 05:32:25PM +0200, Pantelis Antoniou wrote:
> Capebus is created to address the problem of many SoCs that can provide a
> multitude of hardware interfaces but in order to keep costs down the main
> boards only support a limited number of them. The rest are typically brought
> out to pin connectors on to which other boards, named capes are connected and
> allow those peripherals to be used.
> 
> These capes connect to the SoC interfaces but might also contain various other
> parts that may need some kind of driver to work.

I've not yet actually looked at the code but this sounds very similar to
some work I wanted to do on handling coldpluggable modules on reference
designs.  In that case it's not so much about pin count as about the
fact that we have to detect at runtime what's connected to the system
but I think the overall effect is very similar and there's definite
overlap.

Can you please CC me on future versions of the code?
