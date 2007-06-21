From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix clock table walking for OMAP2 variants
Date: Thu, 21 Jun 2007 05:00:25 -0700
Message-ID: <20070621120024.GH20283@atomide.com>
References: <20070614005558.976939568@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070614005558.976939568@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070613 18:00]:
> The various places where the clock rate_table is walked are not all
> checking whether the clock actually exists on the OMAP2 variant.
> 
> Among other things, this results in broken rounding for the OMAP2430
> since the rounding code can potentially find matching speeds that are
> marked as RATE_IN_242X.
> 
> It also results in confusing CPUfreq about what the current speed is.

Thanks, pushing today.

Tony
