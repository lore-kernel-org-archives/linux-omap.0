From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 10/33] ARM: OMAP4: remove old clock data and link in
 new clock init code
Date: Wed, 31 Jul 2013 17:55:47 +0300
Message-ID: <51F92573.7070109@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-11-git-send-email-t-kristo@ti.com>
 <51F81729.5010406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F81729.5010406@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 10:42 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>
>> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c
>> b/arch/arm/mach-omap2/cclock44xx_data.c
>> deleted file mode 100644
>> index 88e37a4..0000000
>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>> +++ /dev/null
> [...]
>> -
>> -int __init omap4xxx_clk_init(void)
>> -{
> arch/arm/mach-omap2/clock44xx.h:int omap4xxx_clk_init(void);
> arch/arm/mach-omap2/io.c:       omap_clk_init = omap4xxx_clk_init;
> code in drivers/clk/omap/clk-44xx.c
>
> Seems goofy to me a little.
> entire purpose of having a clk-44xx.c is:
> a) doing a clk alias for device nodes

I am not quite sure we have mechanisms for doing this (yet).

> b) set_parent, rate

I think this is maybe an idea for future dev and Mike to consider if he 
wants generic clock nodes to have such properties.


> both of these seem to be an old style carry forward and should instead
> be fixes with generic properties IMHO voiding the need for SoC specific
> inits.
>
> instead all we should be doing is call of_clk_init(NULL); at appropriate
> init sequence.
