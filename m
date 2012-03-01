From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Thu, 1 Mar 2012 10:54:41 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 01, 2012 at 07:14:24, Paul Walmsley wrote:
> Hi
> 
> some other observations:
> 
> On Sun, 25 Dec 2011, Vaibhav Hiremath wrote:
> 
> > +static struct powerdomain per_33xx_pwrdm = {
> > +	.name			= "per_pwrdm",
> > +	.voltdm			= { .name = "core" },
> > +	.prcm_partition		= AM33XX_PRM_PARTITION,
> > +	.prcm_offs		= AM33XX_PRM_PER_MOD,
> > +	.pwrsts			= PWRSTS_OFF_RET_ON,
> > +	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
> > +	.pwrstctrl_offs		= AM33XX_PM_PER_PWRSTCTRL_OFFSET,
> > +	.pwrstst_offs		= AM33XX_PM_PER_PWRSTST_OFFSET,
> > +	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
> > +	.banks			= 3,
> > +	.pwrsts_mem_ret		= {
> > +		[0]	= PWRSTS_OFF_RET,	/* icss_mem */
> > +		[1]	= PWRSTS_OFF_RET,	/* per_mem */
> > +		[2]	= PWRSTS_OFF_RET,	/* ram_mem */
> > +	},
> > +	.pwrsts_mem_on		= {
> > +		[0]	= PWRSTS_ON,		/* icss_mem */
> > +		[1]	= PWRSTS_ON,		/* per_mem */
> > +		[2]	= PWRSTS_ON,		/* ram_mem */
> > +	},
> > +};
> 
> According to SPRUH73C Table 8-184 "PM_PER_PWRSTCTRL Register Field 
> Descriptions" the pwrsts_mem_on field for RAM_MEM should be 
> PWRSTS_OFF_RET_ON.
> 
> > +static struct powerdomain mpu_33xx_pwrdm = {
> > +     .name                   = "mpu_pwrdm",
> > +     .voltdm                 = { .name = "mpu" },
> > +     .prcm_partition         = AM33XX_PRM_PARTITION,
> > +     .prcm_offs              = AM33XX_PRM_MPU_MOD,
> > +     .pwrsts                 = PWRSTS_OFF_RET_ON,
> > +     .pwrsts_logic_ret       = PWRSTS_OFF_RET,
> > +     .pwrstctrl_offs         = AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
> > +     .pwrstst_offs           = AM33XX_PM_MPU_PWRSTST_OFFSET,
> > +     .flags                  = PWRDM_HAS_LOWPOWERSTATECHANGE,
> > +     .banks                  = 3,
> > +     .pwrsts_mem_ret         = {
> > +             [0]     = PWRSTS_OFF_RET,       /* mpu_l1 */
> > +             [1]     = PWRSTS_OFF_RET,       /* mpu_l2 */
> > +             [2]     = PWRSTS_OFF_RET,       /* mpu_ram */
> > +     },
> 
> Again SPRUH73C Table 8-191 "PM_MPU_PWRSTCTRL Register Field Descriptions" 
> claims these should simply by PWRSTS_RET.
> 
> > +     .pwrsts_mem_on          = {
> > +             [0]     = PWRSTS_ON,            /* mpu_l1 */
> > +             [1]     = PWRSTS_ON,            /* mpu_l2 */
> > +             [2]     = PWRSTS_ON,            /* mpu_ram */
> > +     },
> > +};
> 
> And the same table claims the MPU_RAM pwrsts_mem_on field should be 
> PWRSTS_OFF_ON.
> 
> Can you please reconcile these differences and let us know which values 
> should be correct?
> 

Paul,

The initialization used in the patch is correct. Unfortunately, the TRM is 
incorrect here. I have already raised this issue with respective folks and soon it will get corrected.

Thanks,
Vaibhav

> thanks
> 
> 
> - Paul
> 
