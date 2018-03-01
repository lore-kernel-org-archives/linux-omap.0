From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree
 based probing
Date: Wed, 28 Feb 2018 19:49:47 -0800
Message-ID: <20180301034947.GE62820@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
 <20180223210100.86732-12-tony@atomide.com>
 <7hr2p41ok8.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7hr2p41ok8.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@baylibre.com> [180301 03:08]:
> Tony Lindgren <tony@atomide.com> writes:
> > We are currently probing smartreflex with omap_device while we are
> > already probing smartreflex related interconnect target module with
> > ti-sysc driver and dts data.
...

> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> I don't have anything else queued for this driver, so feel free to take
> it along with the rest of the series.

Thanks for looking, will do.

Tony
