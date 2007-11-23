From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Enable OMAP3 SDRC clock on init.
Date: Fri, 23 Nov 2007 12:34:12 -0800
Message-ID: <20071123203412.GF559@atomide.com>
References: <1195597014-14054-1-git-send-email-khilman@mvista.com>
	<1195598689.17706.16.camel@vence.hilman.org>
	<1195599539.17706.20.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1195599539.17706.20.camel@vence.hilman.org>
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
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071120 15:00]:
> 
> On Tue, 2007-11-20 at 14:44 -0800, Kevin Hilman wrote:
> > On Tue, 2007-11-20 at 14:16 -0800, Kevin Hilman wrote:
> > > Enable sdrc_ick on init so it doesn't get disabled when
> > > CONFIG_OMAP_RESET_CLOCKS=y
> > 
> > FYI... with this patch and the previous UART3 patch, the 'disable unused
> > clocks' feature is working on 3430SDP

Nice.

> I forgot to mention that for this to work in 32k-timer mode, the my
> 32k-timer fixups for OMAP3430[1] are needed.

I'm pushing those today except the one I think breaks 15xx.

Tony
