From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: hwmod_core: improve the support for clkctrl
 clocks
Date: Fri, 7 Sep 2018 10:15:49 -0700
Message-ID: <20180907171549.GM5662@atomide.com>
References: <1535727683-23930-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1535727683-23930-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Tero Kristo <t-kristo@ti.com> [180831 08:05]:
> This patch adds support for split memory ranges for clkctrl providers.
> This is necessary to support the coming clockdomain based split of
> clkctrl provider ranges, instead of the current CM instance based one.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> Note: This patch can be applied independently, the only hard dependency
> with the clkctrl data split is with the DT changes, those must follow
> everything else.

Tero, looks like this won't apply against v4.19-rc1, can you
please repost?

Regards,

Tony
