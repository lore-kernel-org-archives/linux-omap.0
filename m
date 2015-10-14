From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM: OMAP3: clock: remove un-used core dpll re-program
 code
Date: Wed, 14 Oct 2015 12:35:53 -0700
Message-ID: <20151014193552.GI10113@atomide.com>
References: <1444823356-30324-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1444823356-30324-1-git-send-email-t-kristo@ti.com>
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
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151014 04:52]:
> Remove the OMAP3 core DPLL re-program code, and the associated SRAM
> code that does the low-level programming of the DPLL divider, idling
> of the SDRAM etc.
> 
> This code was never fully implemented in the kernel; things missing
> were driver side handling of core clock changes (they need to account
> for their functional clock rate being changed on-the-fly), and the whole
> framework required for handling this. Thus, there is not much point
> to keep carrying the low-level support code either.

Thanks applying into omap-for-v4.4/cleanup.

Tony
