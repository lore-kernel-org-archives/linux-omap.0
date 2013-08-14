From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info
 from DT
Date: Wed, 14 Aug 2013 18:50:09 +0530
Message-ID: <520B8409.5000708@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 14 August 2013 06:18 PM, Nishanth Menon wrote:
> Hi Rajendra,
> 
> On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> [..]
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 12fa589..e5c804b 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>>         return ret;
>>  }
>>
>> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
>> +                                      struct device_node *np,
>> +                                      int *opt_clks_cnt)
>> +{
>> +       int i, clks_cnt;
>> +       const char *clk_name;
>> +       const char **opt_clk_names;
>> +
>> +       clks_cnt = of_property_count_strings(np, "clock-names");
>> +       if (!clks_cnt)
>> +               return NULL;
>> +
>> +       opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
>> +       if (!opt_clk_names)
>> +               return NULL;
>> +
>> +       for (i = 0; i < clks_cnt; i++) {
>> +               of_property_read_string_index(np, "clock-names", i, &clk_name);
>> +               if (!strcmp(clk_name, "fck"))
> 
> Could we instead parse for names that are "optional,role_name" instead
> of assuming anything other than fck is optional clocks?

you mean look for anything with optional,*? because the role names would change.

> 
>> +                       continue;
>> +               opt_clks_cnt++;
>> +               opt_clk_names[i] = clk_name;
>> +       }
>> +       return opt_clk_names;
>> +}
>> +
> [...]
> --
> Regards,
> Nishanth Menon
> 
