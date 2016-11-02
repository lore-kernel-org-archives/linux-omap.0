From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH 0/5] ARM: OMAP: dead code removal
Date: Wed, 02 Nov 2016 05:51:37 -0700
Message-ID: <5171695.W4AFPtEAdE@diplodocus>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, November 01, 2016 01:36:41 PM Nicolae Rosia wrote:
> Hi,
> 
> I have identified some dead code which can be removed.
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
> 
> 
I think the commit logs for these patches
need a little detail on why the code is
no longer needed. For posterity. 
