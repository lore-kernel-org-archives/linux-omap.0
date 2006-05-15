From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Enable apollon mmc support
Date: Mon, 15 May 2006 03:36:28 -0700
Message-ID: <20060515103627.GR8368@atomide.com>
References: <038001c67262$310a2df0$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <038001c67262$310a2df0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [060507 22:43]:
> Hi
> 
> This patch enables mmc interface on apollon (omap2420)
> The apollon use omap2420 mmc interface instead of another chip as h4
> 
> I wonder there's side-effect on h4 since I always configure mmc mux when
> cpu is omap2420
> Is it right? or do I add machine_is_apollon() when configure mmc mux?
> 
> please let me know :)

To me it looks OK, but let's verify this on H4. First we need to add
back the Menelaus code to drivers/mmc/omap.c though...

Tony
