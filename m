From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP1/2: clock: Remove unused mpurate cmdline
 option
Date: Tue, 24 Jan 2017 07:21:20 -0800
Message-ID: <20170124152119.GE7403@atomide.com>
References: <1485209043-26463-1-git-send-email-amurray@embedded-bits.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1485209043-26463-1-git-send-email-amurray@embedded-bits.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Andrew Murray <amurray@embedded-bits.co.uk> [170123 14:05]:
> The 'mpurate' option, historically used for specifying an initial
> MPU rate at boot, no longer has any effect due to the supporting
> code being removed as it was 'wrong and dangerous' [1].
> 
> This patch removes the remaining dead code associated with the
> __setup macros to avoid confusion and reduce bloat.
> 
> [1] https://patchwork.kernel.org/patch/5954631/
> 
> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
> ---
> Changes since v1:
> 
>  * Remove related omap2_clk_print_new_rates function which is also unused
>    (this was previously used to print clock rates after use of mpurate)
> 
> Changes since v2:
> 
>  * Add missing Signed-off-by

Applying into omap-for-v4.11/soc with Aaro's ack from the previsou
version.

Thanks,

Tony
