From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Wed, 27 Jan 2016 10:56:49 -0800
Message-ID: <20160127185649.GV19432@atomide.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com>
 <56A90971.4020409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A90971.4020409@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [160127 10:17]:
> On 01/27/2016 11:31 AM, Tony Lindgren wrote:
> > Why do you need another reset here? Can't you just implement PM runtime
> > in the driver and do the usual pm_runtime_put_sync followed by
> > pm_runtime_disable?
> 
> The omap_hwmod_enable/disable code does not deal with hardresets (PRCM
> reset lines) and so the pm_runtime_get_sync/put_sync only end up dealing
> with clocks, and we need to invoke the reset functions separately.
> Modules with softresets in SYSCONFIG are ok, as they are dealt with
> properly.

Hmm _reset() in omap_hwmod.c has this to call _assert_hardreset:

	if (oh->class->reset) {
		r = oh->class->reset(oh);
	} else {
		if (oh->rst_lines_cnt > 0) {
			for (i = 0; i < oh->rst_lines_cnt; i++)
				_assert_hardreset(oh, oh->rst_lines[i].name);
			return 0;
		} else {
			r = _ocp_softreset(oh);
			if (r == -ENOENT)
				r = 0;
		}
	}

Care to explain what exactly the problem with the hwmod code not doing
the reset on init?

And why do you need to do another reset in dra7xx_pcie_remove()?

> > Basically I'm wondering how come we need these platform data callbacks
> > at all.
> 
> The hardresets are controlled through the
> omap_device_assert(deassert)_hardreset functions, and since these are
> limited to mach-omap2, we are invoking them through platform data callbacks.

Right.. But I'm wondering about the why you need to do this in the
driver at all part :)

Regards,

Tony
