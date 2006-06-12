From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2 DMA burst support
Date: Mon, 12 Jun 2006 13:18:39 -0700
Message-ID: <20060612201838.GC5942@atomide.com>
References: <00f601c689d6$62acdb60$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <00f601c689d6$62acdb60$c7a3580a@swcenter.sec.samsung.co.kr>
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

* Kyungmin Park <kyungmin.park@samsung.com> [060606 19:03]:
> 
> OMAP2 DMA burst setting support

Great, pushed. I've also pushed a patch to fix dma channel irqs on 24xx:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=5ecbcfcb9e3922c15ca7c93ca67db64f239c901e

Regards,

Tony
