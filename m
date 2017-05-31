From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 0/6] ARM: OMAP2+: preparation for clk/clkctrl support
Date: Wed, 31 May 2017 12:53:40 -0700
Message-ID: <20170531195339.GL3730@atomide.com>
References: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
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

* Tero Kristo <t-kristo@ti.com> [170531 08:03]:
> Hi,
> 
> This series is evolution of the v3b of the same series:
> https://www.spinics.net/lists/arm-kernel/msg584344.html
> 
> Changes compared to v3b:
> 
> - Added patch #3 which stores the physical address for PRCM instances
>   in addition to the virtual addresses
> - Fixed patch #5 to use physical base address for xlate instead of
>   the OMAP2_L4_IO_ADDRESS hack
> - Dropped unnecessary device node passing from patch #6 which makes
>   the code slightly more readable also

I gave this series a quick test with no other changes and
noticed that n8x0 stopped booting. Other than that looks
pretty good to me.

Regards,

Tony
