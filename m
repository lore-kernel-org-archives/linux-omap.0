From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP1: enable GENERIC_IRQ_CHIP
Date: Tue, 28 Jun 2011 07:54:57 -0700
Message-ID: <1309272897.6231.24.camel@vence>
References: <1307491366-28793-1-git-send-email-khilman@ti.com>
	<20110614115056.GT3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110614115056.GT3352@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2011-06-14 at 04:50 -0700, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [110607 16:58]:
> > OMAP1 needs this also since GPIO driver (common for all OMAPs) is
> > being converted to use generic IRQ chip.
> > 
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Maybe queue this together with your GPIO patches?
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Since this only touches arch/arm/plat-omap/*, this should probably go
through your tree, and I don't have any more GPIO fixes to queue for
this merge window.

Kevin
