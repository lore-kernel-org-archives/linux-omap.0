From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] omap: hwmod: add default reset handling support
Date: Tue, 9 Feb 2016 21:34:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602092131280.27214@utopia.booyaka.com>
References: <1454929941-23949-1-git-send-email-kishon@ti.com> <56B9037C.2050203@ti.com> <56B9767D.7000708@ti.com> <56BA258D.3040002@ti.com> <56BA49D4.8040900@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BA49D4.8040900@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Suman Anna <s-anna@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, bhelgaas@google.com, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 9 Feb 2016, Dave Gerlach wrote:

> Sorry got held up by the discussion here [1], that regression affects
> rmmod/re-insmod of wkup_m3_rproc as well. If I revert the guilty patch
> 5de85b9d57ab ("PM / runtime: Re-init runtime
> PM states at probe error and driver unbind") and apply these three patches, on
> initial probe of the wkup_m3_rproc and wkup_m3_ipc drivers in v4.5-rc3 I see:
> 
> [   15.593460] omap_hwmod: wkup_m3: _wait_target_disable failed
> 
> Which is triggered by the reset of the wkup_m3 from the wkup_m3_ipc driver
> when booting the wkup_m3_rproc. Flow is:
> 
> 1. wkup_m3_rproc probes and calls pm_runtime_get_sync, which calls hwmod
> _enable but bails out because _are_all_hardreset_lines_asserted(oh) causes it
> to return 0.
> 
> 2. wkup_m3_ipc probes and calls rproc_boot, which triggers
> omap_device_deassert_hardreset in order to let the wkup_m3 start.

The patches that Kishon posted shouldn't change the existing hardreset 
behavior for any IP block with HWMOD_CUSTOM_HARDRESET marked.  If the
behavior changes before and after that patch set, something isn't right.

> It is inside the omap_device_deassert_hardreset ( and inside that,
> omap_hwmod_deassert_hardreset) where I end up with the error message, but
> after that rmmod/insmod of the module over and over again shows no additional
> error messages (at least with the above mentioned PM patch reverted).

I no longer recall why we had the _are_all_hardreset_lines_asserted(oh) 
test in place.  But we might be able to drop it now that we have the 
HWMOD_CUSTOM_HARDRESET flag.
 

- Paul
