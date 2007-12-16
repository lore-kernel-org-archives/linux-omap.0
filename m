From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM fixes for OMAP1
Date: Sat, 15 Dec 2007 16:47:23 -0800
Message-ID: <20071216004722.GI7388@atomide.com>
References: <11974491911449-git-send-email-vivek.kutal@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11974491911449-git-send-email-vivek.kutal@celunite.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vivek Kutal <vivek.kutal@celunite.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Vivek Kutal <vivek.kutal@celunite.com> [071212 00:47]:
> This patch does the following
> 	- Fixes the omap_pm_idle() code so that we enter WFI mode in idle.
> 	- /sys/power/sleep_while_idle is created only when 32k timer is used.

Pushing today.

Tony
