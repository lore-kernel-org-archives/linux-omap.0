From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
Date: Fri, 5 Apr 2013 14:34:34 -0700
Message-ID: <20130405213433.GF10155@atomide.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130405 06:01]:
> OMAP5 has backward compatible PRCM block and it's programming
> model is mostly similar to OMAP4. Same is going to be maintained
> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
> management code so that it can be re-used on OMAP5 and later devices.
> 
> While at it, update the kernel-doc for omap4_pm_init().
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    9 +--
>  arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   58 ++++++++++++++++----
>  .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
>  3 files changed, 53 insertions(+), 14 deletions(-)
>  rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (83%)
>  rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)

I suggest you leave out the rename. That just adds churn and has
flame potential.

Regards,

Tony
