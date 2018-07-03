From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: hwmod: RTC: Don't assume lock/unlock will be called
 with irq enabled
Date: Tue, 3 Jul 2018 02:38:23 -0700
Message-ID: <20180703093823.GU112168@atomide.com>
References: <1529572388-21890-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1529572388-21890-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180621 02:16]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> When the RTC lock and unlock functions were introduced it was likely
> assumed that they would always be called from irq enabled context, hence
> the use of local_irq_disable/enable. This is no longer true as the
> RTC+DDR path makes a late call during the suspend path after irqs
> have been disabled to enable the RTC hwmod which calls both unlock and
> lock, leading to IRQs being reenabled through the local_irq_enable call
> in omap_hwmod_rtc_lock call.
> 
> To avoid this change the local_irq_disable/enable to
> local_irq_save/restore to ensure that from whatever context this is
> called the proper IRQ configuration is maintained.

Thanks applying into omap-for-v4.19/soc.

Tony
