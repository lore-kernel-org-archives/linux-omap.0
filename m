From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix onenand initialization to avoid
 filesystem corruption
Date: Mon, 8 Feb 2016 12:26:46 -0800
Message-ID: <20160208202646.GA19432@atomide.com>
References: <linux-kernel@vger.kernel.org>
 <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160208193644.GU19432@atomide.com>
 <56B8F71A.7090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B8F71A.7090102@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: rogerq@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, pavel@ucw.cz, nm@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160208 12:15]:
> Hi
> 
> On  8.02.2016 21:36, Tony Lindgren wrote:
> >
> >OK. So probably the INT or RDY polarity made the ECC not work.
> >
> 
> Well, ECC disable bit (ONENAND_SYS_CFG1_NO_ECC) was set as well, so most
> probably it was the bugger :)

Oh OK that explains.

> >Aaro, care to dump out also the nolo configured CFG1 value from
> >n8x0 and n9(50)?
> >
> >You can do it by adding something like this to the beginning
> >of set_onenand_cfg():
> >
> 
> Also, do not forget to restore HWMOD_INIT_NO_RESET in gpmc_hwmod in question
> and (maybe) revert e7b11dc7b77bfce0a351230a5feeadc1d0bba997.

Probably just enabling CONFIG_OMAP_GPMC_DEBUG allows dumping
the GPMC configuration. And it sounds like it's a good idea
to have this patch enabled.

Regards,

Tony
