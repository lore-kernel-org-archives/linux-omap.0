From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/5] ARM: OMAP: dead code removal
Date: Wed, 9 Nov 2016 14:47:18 -0700
Message-ID: <20161109214718.GE2428@atomide.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nicolae Rosia <Nicolae_Rosia@mentor.com> [161104 07:02]:
> Hi,
> 
> I have identified some dead code which can be removed.
> 
> v2:
> - Added details on each commit on how the code ended up unused.
> 
> Nicolae Rosia (5):
>   ARM: OMAP4: kill omap4_pmic_init and omap4_pmic_get_config
>   ARM: OMAP3: kill omap3_pmic_get_config and twl_{get,set}_voltage
>   ARM: OMAP3: kill omap3_pmic_init
>   ARM: OMAP2: kill omap2_pmic_init
>   ARM: OMAP: kill omap_pmic_init
> 
>  arch/arm/mach-omap2/twl-common.c | 483 ---------------------------------------
>  arch/arm/mach-omap2/twl-common.h |  24 --
>  2 files changed, 507 deletions(-)

Thanks applying all these into omap-for-v4.10/legacy.

Regards,

Tony
