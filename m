From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.18-omap] omap2/gpmc updates
Date: Thu, 19 Oct 2006 16:35:13 +0300
Message-ID: <20061019133511.GD9983@atomide.com>
References: <200610181342.14796.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610181342.14796.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061018 23:44]:
> GPMC updates:
>  - bugfixes: wrong/missing flags, omitted write, wrong test
>  - don't map memory segments starting at zero
>  - improve debug messaging
>  - export gpmc_get_fclk_period() since it's needed to calc timings
>  - expect gpmc_cs_set_timings() caller to have initialized sync vs async
> 
> Note that this API is glitchy; likely the best fix would be to add
> a member to "struct gpmc_timings" to hold GPMC_CONFIG1, since that
> holds one key aspect of the GPMC timings (the gpmc_fclk divisor,
> and sync vs. async == whether that divisor matters).

Pushing this today.

Tony
