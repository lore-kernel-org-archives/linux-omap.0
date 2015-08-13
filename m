From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH-next 1/4] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
Date: Thu, 13 Aug 2015 16:37:07 +0100
Message-ID: <20150813153707.GF7576@n2100.arm.linux.org.uk>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1439409416-32673-2-git-send-email-balbi@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Dirk Behme <dirk.behme@de.bosch.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 12, 2015 at 02:56:53PM -0500, Felipe Balbi wrote:
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

I don't remember all the details from Feb 2013 on why we made that
change.  If this is proven safe, then I guess it's okay.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
