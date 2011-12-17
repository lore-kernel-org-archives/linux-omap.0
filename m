From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 5/6] clk: basic gateable and fixed-rate clks
Date: Fri, 16 Dec 2011 16:57:52 -0800
Message-ID: <CAJOA=zMcRzZ8LAzFzf_=1L2ZCrFHHjx_PTsxkb6US4HpWp8BOA@mail.gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
	<1323834838-2206-6-git-send-email-mturquette@linaro.org>
	<4EE830D5.5070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4EE830D5.5070305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 13, 2011 at 9:15 PM, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 14/12/11 14:53, Mike Turquette wrote:
>
>> Many platforms support simple gateable clks and fixed-rate clks that
>> should not be re-implemented by every platform.
>>
>> This patch introduces a gateable clk with a common programming model of
>> gate control via a write of 1 bit to a register. =A0Both set-to-enable a=
nd
>> clear-to-enable are supported.
>>
>> Also introduced is a fixed-rate clk which has no reprogrammable aspects.
>>
>> The purpose of both types of clks is documented in drivers/clk/basic.c.
>>
>> TODO: add support for a simple divider, simple mux and a dummy clk for
>> stubbing out platform support.
>>
>> Based on original patch by Jeremy Kerr and contribution by Jamie Iles.
>>
>> Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>> Cc: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
>
> <snip>
>
>> +int clk_register_gate(struct device *dev, const char *name, unsigned lo=
ng flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct clk *fixed_parent, void __iomem *reg, u=
8 bit_idx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int set_to_enable)
>> +{
>> + =A0 =A0 struct clk_hw_gate *gclk;
>> + =A0 =A0 struct clk *clk;
>> +
>> + =A0 =A0 gclk =3D kmalloc(sizeof(struct clk_hw_gate), GFP_KERNEL);
>> +
>> + =A0 =A0 if (!gclk) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: could not allocate gated clk\n", _=
_func__);
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
>
>
> You could avoid having two sets of operations if you stored the
> set_to_enable value in struct clk_hw_gate. It might be useful to store
> additional information in struct clk_hw_gate if you also want to extend
> to supporting non-32bit registers (readb, etc), clocks with write only
> registers, or support clocks which require more than one bit to be set
> or cleared to enable them, etc. See the basic mmio gpio driver for a
> similar case.

I haven't given the basic clks enough attention, mostly because I
haven't started using them yet in my own platform's conversion to
common struct clk :-/

I think the original reason for the extra operations is to avoid the
conditional in the enable/disable path, but if we're going to end up
adding other conditionals anyways (such as the register locking in the
iMX platform implementation) then we should probably forget about that
approach and just deal with the complexity in one set of common
enable/disable functions.

Thanks for the review,
Mike

>
> ~Ryan
>
