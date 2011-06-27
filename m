From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
Date: Mon, 27 Jun 2011 00:51:02 -0700
Message-ID: <20110627075101.GE23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin> <87ei2ka2u6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87ei2ka2u6.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110623 10:08]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > There's no need to initialize the dmtimer framework early.
> > Just mark the clocksource and timesource as reserved, and
> > initialize dmtimer with an arch_initcall.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
> Also, when you are able to fully get rid of omap_dm_timer_init(), you
> can probably remove it from dmtimer.h and make it static in dmtimer.c

Good catch. That can be made static now.

Tony
