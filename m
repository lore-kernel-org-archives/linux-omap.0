From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
Date: Mon, 3 Jun 2013 09:50:53 +0200
Message-ID: <CAGGh5h2uV-cpaf1un-bf6H8BBw=XLZWNNhihXxhVLGpGva8OdQ@mail.gmail.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
	<20130531193211.21525.68958@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:60327 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab3FCHuz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 03:50:55 -0400
Received: by mail-we0-f182.google.com with SMTP id w58so1446099wes.27
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 00:50:53 -0700 (PDT)
In-Reply-To: <20130531193211.21525.68958@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: paul@pwsan.com, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2013/5/31 Mike Turquette <mturquette@linaro.org>:
> Quoting Jean-Philippe Francois (2013-05-30 01:50:27)
>> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw o=
f the clock
>> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all conc=
erned clock
>> have parent defined as clk_divider. Instead of using container_of to=
 eventually get
>> to the register and directly mess with the divider, change freq via =
clk_set_rate,
>> and let the clock framework toggle the divider value.
>> Tested with  3.9 on dm3730.
>>
>> Signed-off-by: Jean-Philippe Fran=EF=BF=BD=EF=BF=BDois <jp.francois@=
cynove.com>
>
> Did you use git-format-patch to create this patch?  Its a bit nicer t=
o
> use that or if you just use diff then use "diff -up" or "diff -uprN"
> (taken from Documentation/SubmittingPatches.txt).
>
It is easier for my build system to work with tarball + quilt patches, =
so
I am not working with git. I will look into the alternative you provide=
d.

> Also did you test this to make sure it works?  I don't mean a boot te=
st,
> but actually disabling/re-enabling an HSDIVIDER on 3630?  The previou=
s
> code just programmed the clksel field to 1, and this code divides the
> rate by 2, then restores it.  I just used that as an example in my
> previous email and it needs to be verified that it works (though it
> should if I remember this errata correctly).
>

Yes, it is exactly what happens on my board when using the camera, beca=
use
the sensor clock is provided by the SoC. So this patch works for this
particular clock.
If the asked frequency is the lower limit of the frequency range, then
asking for half the
frequency won't change the divider, but I think it is not a problem in =
practice.

> If that testing is done and everything looks good then please add:
>
> Acked-by: Mike Turquette <mturquette@linaro.org>
>
How should I proceed ? Should I just add the acked by below, or should
I resend the patch ?

Jean-Philippe Fran=C3=A7ois

>>
>> Index: b/arch/arm/mach-omap2/clock36xx.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/arch/arm/mach-omap2/clock36xx.c
>> +++ b/arch/arm/mach-omap2/clock36xx.c
>> @@ -39,30 +39,25 @@
>>   */
>>  int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk=
)
>>  {
>> -       struct clk_hw_omap *parent;
>> -       struct clk_hw *parent_hw;
>> -       u32 dummy_v, orig_v, clksel_shift;
>>         int ret;
>>
>>         /* Clear PWRDN bit of HSDIVIDER */
>>         ret =3D omap2_dflt_clk_enable(clk);
>>
>> -       parent_hw =3D __clk_get_hw(__clk_get_parent(clk->clk));
>> -       parent =3D to_clk_hw_omap(parent_hw);
>> -
>> -       /* Restore the dividers */
>> +       /* kick parent's clksel register after toggling PWRDN bit */
>>         if (!ret) {
>> -               clksel_shift =3D __ffs(parent->clksel_mask);
>> -               orig_v =3D __raw_readl(parent->clksel_reg);
>> -               dummy_v =3D orig_v;
>> -
>> -               /* Write any other value different from the Read val=
ue */
>> -               dummy_v ^=3D (1 << clksel_shift);
>> -               __raw_writel(dummy_v, parent->clksel_reg);
>> -
>> -               /* Write the original divider */
>> -               __raw_writel(orig_v, parent->clksel_reg);
>> +               struct clk *parent =3D clk_get_parent(clk->clk);
>> +               unsigned long parent_rate =3D clk_get_rate(parent);
>> +               ret =3D clk_set_rate(parent, parent_rate/2);
>> +               if(ret)
>> +                       goto badfreq;
>> +               ret =3D clk_set_rate(parent, parent_rate);
>> +               if(ret)
>> +                       goto badfreq;
>>         }
>> +       return ret;
>>
>> + badfreq :
>> +       omap2_dflt_clk_disable(clk);
>>         return ret;
>>  }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
