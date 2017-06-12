From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: PM: stop early on systems without twl
Date: Mon, 12 Jun 2017 00:39:47 -0700
Message-ID: <20170612073946.GU3730@atomide.com>
References: <20170609223223.19079-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170609223223.19079-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170609 15:36]:
> Motorola Droid 4 has an OMAP4, but no TWL6030. It currently
> complains verbosely about this during boot:
> 
> twl: not initialized
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
> omap2_set_init_voltage: unable to find boot up OPP for vdd_core
> omap2_set_init_voltage: unable to set vdd_core
> omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
> omap2_set_init_voltage: unable to set vdd_iva
> 
> While proper support for CPCAP should be added at some point,
> let's exit early in omap2_common_pm_late_init() until that
> has been implemented to avoid the above errors. There is still
> a reminder about missing PM in dmesg:
> 
> Missing OMAP4 PM for this platform!

Great good to see this dmesg spam go away. Applying into
omap-for-v4.13/soc-v3 thanks.

Tony
