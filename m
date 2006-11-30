From: tony@atomide.com
Subject: Re: [PATCH] Exporting reserved APIs in GPMC library.
Date: Thu, 30 Nov 2006 14:43:19 -0800
Message-ID: <20061130224318.GC9605@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7E534@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7E534@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061127 08:16]:
> Hi,
> 
> The attached patch is to export two APIs (gpmc_cs_set_reserved and
> gpmc_cs_reserved) of GPMC library.
> 
> This allows other libraries and drivers to access these APIs with out
> doing a gpmc_request. 
> 
> Reason: If I have already configured a GPMC CS in boot loader I might
> not be interested in doing the same again in Kernel. However I might
> want to reserve this particular CS so that it doesn't show as free when
> others do a gpmc_request. 

Pushing your two patches today as a single patch. Left out the HISTORY
part to cut down on clutter as it already shows up in git.

Regards,

Tony
