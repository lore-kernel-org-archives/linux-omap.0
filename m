From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH-v4.2-rc6 1/5] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
Date: Wed, 12 Aug 2015 00:15:27 -0700
Message-ID: <20150812071527.GP4215@atomide.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1439242911-715-2-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150810 14:45]:
> This reverts commit 904464b91eca8c665acea033489225af02eeb75a.
> 
> The problem pointed out by commit 904464b91eca ("ARM: 7655/1:
> smp_twd: make twd_local_timer_of_register() no-op for nosmp")
> doesn't exist anymore.
> 
> We can safely boot with nosmp and the warning won't show up.
> 
> The other side benefit of this patch is that TWD has a chance
> to probe on single-core A9 systems such as AM437x which sport
> TWD.

Can you please upload this into Russell's patch tracking system
if no comments? Please also feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
