From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fixing SD response type 6 vs. 1
Date: Fri, 10 Aug 2007 00:34:56 -0700
Message-ID: <20070810073455.GG8658@atomide.com>
References: <20070608135942.2884.86105.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070608135942.2884.86105.stgit@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Ragner Magalhaes <ragner.magalhaes@indt.org.br> [070608 07:06]:
> From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
> 
> Fixing reponse type R6 for CMD3 when SD Card will be attached.
> 
> Ignoring OMAP_MMC_STAT_CARD_ERR, treating it as if the command
> completed correctly.

Just to confirm, this one is already applied via LKML.

Tony
