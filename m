From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] ARM: OMAP2+: Fix save_secure_ram_context for rodata
Date: Tue, 19 Jan 2016 13:57:45 -0800
Message-ID: <20160119215745.GF19432@atomide.com>
References: <1453225734-16993-1-git-send-email-tony@atomide.com>
 <1453225734-16993-4-git-send-email-tony@atomide.com>
 <569E845F.7080001@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <569E845F.7080001@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Richard Woodruff <r-woodruff2@ti.com>, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, linux-omap@vger.kernel.org, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [160119 10:46]:
> >--- a/arch/arm/mach-omap2/sleep34xx.S
> >+++ b/arch/arm/mach-omap2/sleep34xx.S
> >@@ -93,8 +93,12 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
> >  	ldmfd	sp!, {pc}	@ restore regs and return
> >  ENDPROC(enable_omap3630_toggle_l2_on_restore)
> >
> >-	.text
> >-/* Function to call rom code to save secure ram context */
> >+/*
> >+ * Function to call rom code to save secure ram context, This gets
> 
>    s/,/./?

Will fix thanks.

Tony
