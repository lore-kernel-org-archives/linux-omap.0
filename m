From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: Take 2 musb_hdrc cleanup (was: [PATCH] MUSB_HDRC: Get rid of pr_*()
	and printk() clauses)
Date: Wed, 15 Aug 2007 13:23:22 -0400
Message-ID: <11871986031263-git-send-email-felipe.lima@indt.org.br>
References: <200708150944.28365.david-b@pacbell.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708150944.28365.david-b@pacbell.net>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi dave,

> A patch moving bare printks to something else would be a lot
> easier to quickly review than something changing a whole bunch
> of other stuff.

As you asked, here's a patch converting all printk() to dev_*
macros. Does this one look better?

Thanks in advance,

Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

INdT - OSMRC - Manaus
Core Team
