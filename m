From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3] ARM: OMAP3: Fix hardware detection for omap3630 when
 booted with device tree
Date: Tue, 8 Oct 2013 07:00:22 -0500
Message-ID: <5253F3D6.5060403@ti.com>
References: <20131007192009.GA8949@atomide.com>
 <1381178629-13488-1-git-send-email-nm@ti.com>
 <20131008000515.GA2097@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131008000515.GA2097@earth.universe>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Felipe <balbi@ti.com>, Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/07/2013 07:05 PM, Sebastian Reichel wrote:
> On Mon, Oct 07, 2013 at 03:43:49PM -0500, Nishanth Menon wrote:
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 39c7838..4fe5b9c 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -113,6 +113,7 @@ MACHINE_END
>>  #ifdef CONFIG_ARCH_OMAP3
>>  static const char *omap3_boards_compat[] __initdata = {
>>  	"ti,omap3",
>> +	"ti,omap343x",
>             ^^^^
> You used omap36xx everywhere, so I guess this should be
> "ti,omap34xx"?

3630 has at least two variants:
http://www.ti.com/product/omap3621
http://www.ti.com/product/omap3630

It got further spun off in 37xx family:
http://www.ti.com/product/dm3730 (DM3730 and DM3725)

3430 is no longer in production - but just had a single version (at
least what I can remember).

3530 variant of 3430 on the other hand has a few:
http://processors.wiki.ti.com/index.php/OMAP3_Overview


I am ok to change to ti,omap34xx if folks think that is the right
thing to do. Personally, I might prefer to handle 35xx family slightly
differently considering deltas.

-- 
Regards,
Nishanth Menon
