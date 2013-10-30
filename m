From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 05/43] CLK: TI: add DT alias clock registration mechanism
Date: Wed, 30 Oct 2013 10:29:28 +0200
Message-ID: <5270C368.9000701@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>	<1382716658-6964-6-git-send-email-t-kristo@ti.com>
 <CAHCPf3uPhkVhdn3Db06YZfrwQuA7khdZEXiZ+pqJ06J9YdBoLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCPf3uPhkVhdn3Db06YZfrwQuA7khdZEXiZ+pqJ06J9YdBoLg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: nm@ti.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, paul@pwsan.com, Mike Turquette <mturquette@linaro.org>, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 10/29/2013 07:50 PM, Matt Sealey wrote:
> On Fri, Oct 25, 2013 at 10:56 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> Some devices require their clocks to be available with a specific
>> dev-id con-id mapping. With DT, the clocks can be found by default
>> only with their name, or alternatively through the device node of
>> the consumer. With drivers, that don't support DT fully yet, add
>> mechanism to register specific clock names.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Tested-by: Nishanth Menon <nm@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> You guys are wonderful, by the way ;)
>
>> +void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
>> +{
>> +       struct ti_dt_clk *c;
>> +       struct device_node *node;
>> +       struct clk *clk;
>> +       struct of_phandle_args clkspec;
>> +
>> +       for (c = oclks; c->node_name != NULL; c++) {
>> +               node = of_find_node_by_name(NULL, c->node_name);
>> +               clkspec.np = node;
>> +               clk = of_clk_get_from_provider(&clkspec);
>> +
>> +               if (!IS_ERR(clk)) {
>> +                       c->lk.clk = clk;
>> +                       clkdev_add(&c->lk);
>> +               } else {
>> +                       pr_warn("%s: failed to lookup clock node %s\n",
>> +                               __func__, c->node_name);
>> +               }
>> +       }
>> +}
>
> I have one question here, what makes this part of the patch
> TI-specific at all except the definition of the structure ti_dt_clk?
> Mapping DT clocks to generic clkdev legacy namings seems like it would
> be a necessary evil across *all* SoC platforms.
>
> I would say there is a good case for this being generic and used by
> all platforms waiting for con->id/dev->id to be moved to DT-awareness,
> the structure itself is very generic within clkdev as long as the
> drivers conformed anyway (and if they didn't, none of this helps) and
> I don't think it really needs to be a TI-only thing. The next thing
> that's going to happen when another platform arrives that wants to do
> the same thing is duplication or consolidation - so it would probably
> be a good idea to make this generic to start.
>
> While there the names could be a bit more descriptive -
> dt_clk_name_lookup_map_register(), struct dt_clk_name_lookup_map,
> DT_CLK_LOOKUP_MAP() ..? The current namespace makes it look like this
> is the absolute correct thing to do under all circumstances, but in
> fact this is purely for mapping the old way to the new, better way..
> in the event a brand new platform arrives, with all new drivers (or
> only compliant drivers), none of this code should be implemented for
> it and it should be presented this way.

An earlier implementation of this patch (or at least a patch that tries 
to accomplish the same as this does, add support for legacy devices) did 
try to add generic solution. There was some discussion on it and I 
decided to drop it due to bad feedback.

See: http://www.spinics.net/lists/linux-omap/msg95147.html

-Tero
