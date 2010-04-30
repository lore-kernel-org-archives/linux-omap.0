From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig
Date: Fri, 30 Apr 2010 13:50:03 -0700
Message-ID: <20100430205003.GG29604@atomide.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203411.25812.30019.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100430203411.25812.30019.stgit@baageli.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100430 13:32]:
> Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> omap FB code is fixed.

This one I'll drop as soon as the problem is sorted out with
CONFIG_FB_OMAP.

Tony
