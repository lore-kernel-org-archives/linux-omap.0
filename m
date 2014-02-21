From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] ARM: EDMA: Use platform_get_resource functions for DT
Date: Fri, 21 Feb 2014 11:36:27 -0600
Message-ID: <53078E9B.5010806@ti.com>
References: <1392956661-28787-1-git-send-email-joelf@ti.com>
 <20140221121548.GF8783@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140221121548.GF8783@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/21/2014 06:15 AM, Mark Rutland wrote:
>> Also, while at it get rid of the assumption in the code that "CC" is at reg
>> index 0 in the DT and xbar is at offset 1. Instead use reg-names to get the
>> memory resource in concern keeping things much cleaner and simpler. This also
>> makes it possible to have multiple channel controllers.
> 
> While this is nice I think we have to have a fallback to the existing
> behaviour if there's no reg-names property present, unless we know for
> certain no-one is possibly using an existing DTB.

Yes, its true it break existing DTBs but currently only 2 TI SoCs use EDMA this
way, the vast majority of EDMA users are yet to follow where we can do it right.
 Further, the old bindings are really limiting specially the 2 CC case and if
additionally memory maps are used in the future. So keeping the old binding is
limiting in this regard.

Here is what the platform_data used to look like when used by mach-davinci:

static struct resource da850_edma_resources[] = {
        {
                .name   = "edma_cc0",
                .start  = DA8XX_TPCC_BASE,
                .end    = DA8XX_TPCC_BASE + SZ_32K - 1,
                .flags  = IORESOURCE_MEM,
        },
        {
                .name   = "edma_tc0",
                .start  = DA8XX_TPTC0_BASE,
                .end    = DA8XX_TPTC0_BASE + SZ_1K - 1,
                .flags  = IORESOURCE_MEM,
        },
        {
                .name   = "edma_tc1",
                .start  = DA8XX_TPTC1_BASE,
                .end    = DA8XX_TPTC1_BASE + SZ_1K - 1,
                .flags  = IORESOURCE_MEM,
        },
        {
                .name   = "edma_cc1",
                .start  = DA850_TPCC1_BASE,
                .end    = DA850_TPCC1_BASE + SZ_32K - 1,
                .flags  = IORESOURCE_MEM,
        },

As you can see, there are several memory maps and different interpretations.
Considering this, IMO- it makes sense to pay a small price to keep the semantics
sane.

On the other hand, the other 2 options are:
1. We add a fallback if reg-names look up fails.
2. We inject reg-names property into edma DT nodes that don't have them, and
make sure all future dtsi with edma nodes mention the reg-names property.

These 2 are a bit error prone though, for example if someone deliberately
forgets to mention reg-names, and the code still works, but misbehaves in some way.

Regards,
-Joel
