From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
Date: Sat, 26 Nov 2011 22:03:47 -0800
Message-ID: <CAJOA=zOMKKRKZ2P8XKAVLPWbhttizWubRiTjtCBz=myjivnRaA@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-5-git-send-email-mturquette@linaro.org> <20111126134807.GD19025@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:46792 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753050Ab1K0GEJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Nov 2011 01:04:09 -0500
In-Reply-To: <20111126134807.GD19025@S2100-06.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, aul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org

On Sat, Nov 26, 2011 at 5:48 AM, Shawn Guo <shawn.guo@freescale.com> wr=
ote:
> On Mon, Nov 21, 2011 at 05:40:46PM -0800, Mike Turquette wrote:
>> Many platforms support simple gateable clks and fixed-rate clks that
>> should not be re-implemented by every platform.
>>
>> This patch introduces a gateable clk with a common programming model=
 of
>> gate control via a write of 1 bit to a register. =A0Both set-to-enab=
le and
>> clear-to-enable are supported.
>>
>> Also introduced is a fixed-rate clk which has no reprogrammable aspe=
cts.
>>
>> The purpose of both types of clks is documented in drivers/clk/basic=
=2Ec.
>>
> What I have seen is drivers/clk/clk-basic.c.

Will fix in v4.

>> +int clk_register_gate(struct device *dev, const char *name, unsigne=
d long flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct clk *fixed_parent, void __iomem *re=
g, u8 bit_idx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int set_to_enable)
>> +{
>> + =A0 =A0 struct clk_hw_gate *gclk;
>> + =A0 =A0 struct clk *clk;
>> +
>> + =A0 =A0 gclk =3D kmalloc(sizeof(struct clk_hw_gate), GFP_KERNEL);
>> +
>> + =A0 =A0 if (!gclk) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: could not allocate gated clk\n=
", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk =3D &gclk->clk;
>> +
>> + =A0 =A0 /* struct clk_hw_gate assignments */
>> + =A0 =A0 gclk->fixed_parent =3D fixed_parent;
>> + =A0 =A0 gclk->reg =3D reg;
>> + =A0 =A0 gclk->bit_idx =3D bit_idx;
>> +
>> + =A0 =A0 /* struct clk assignments */
>> + =A0 =A0 clk->name =3D name;
>> + =A0 =A0 clk->flags =3D flags;
>> +
>> + =A0 =A0 if (set_to_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk->ops =3D &clk_hw_gate_set_enable_ops;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk->ops =3D &clk_hw_gate_set_disable_ops;
>> +
>> + =A0 =A0 clk_init(NULL, clk);
>> +
>> + =A0 =A0 return 0;
>
> The device tree support needs to get this 'struct clk *', so we may
> want to have all these registering functions return the 'clk'.

Thanks for the input.  Truthfully I'm very DT-ignorant so I'm happy to
reshape any APIs for that topic.  Hope to fix that soon.

Thanks for reviewing,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
