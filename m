From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: omap2: am437x: rollback to use
 omap3_gptimer_timer_init()
Date: Tue, 27 Dec 2016 09:35:49 -0800
Message-ID: <20161227173549.GS4920@atomide.com>
References: <1480910264-5126-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480910264-5126-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [161204 19:58]:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The commit 55ee7017ee31 ("arm: omap2: board-generic: use
> omap4_local_timer_init for AM437x") unintentionally changes the
> clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.
> 
> Unfortunately, the SyncTimer32K is starving from frequency deviation
> as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
> as clocksource") and, as reported by Franklin [1], even its monotonic
> nature is under question (most probably there is a HW issue, but it's
> still under investigation).
> 
> Taking into account above facts It's reasonable to rollback to the use
> of omap3_gptimer_timer_init().
> 
> [1] http://www.spinics.net/lists/linux-omap/msg127425.html

Applying into omap-for-v4.10/fixes thanks.

Tony
