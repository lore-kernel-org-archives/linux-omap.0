From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0108/1529] Fix typo
Date: Fri, 10 Jun 2016 04:18:55 -0700
Message-ID: <20160610111855.GZ22406@atomide.com>
References: <20160521115032.4966-1-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160521115032.4966-1-andrea.gelmini@gelma.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: linux-omap@vger.kernel.org, trivial@kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrea Gelmini <andrea.gelmini@gelma.net> [160521 04:52]:
> --- a/arch/arm/mach-omap2/sdrc.h
> +++ b/arch/arm/mach-omap2/sdrc.h
> @@ -175,8 +175,8 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
>   * don't adjust it down as your clock period increases the refresh interval
>   * will not be met. Setting all parameters for complete worst case may work,
>   * but may cut memory performance by 2x. Due to errata the DLLs need to be
> - * unlocked and their value needs run time calibration.	A dynamic call is
> - * need for that as no single right value exists acorss production samples.
> + * unlocked and their value needs run time calibration. A dynamic call is
> + * need for that as no single right value exists across production samples.

Applying patches 102 - 108 into omap-for-v4.8/soc thanks.

Tony
