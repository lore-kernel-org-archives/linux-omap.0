From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Mon, 30 Sep 2019 16:35:38 +0300
Message-ID: <d2bec234-be61-5ac1-2899-63d29660a80c@ti.com>
References: <20190510194229.20628-1-aford173@gmail.com>
 <af325707-3e42-493d-e858-77878ef06138@ti.com>
 <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
 <7ada0752-6f65-2906-cb29-a47c9490fd57@ti.com>
 <CAHCN7xJexJvh71vyb31ETgo=n_y_CupHH-AZwVK9mZe3GzJfEQ@mail.gmail.com>
 <845055e2-8182-de74-2077-629fdf50ac6c@ti.com>
 <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
 <854f6130-c8a8-81cb-aa76-4830f218ae54@ti.com>
 <CAHCN7xKocdiWOdmoWQV3POr84qte6WNt0QbQRAwxKSvU8COB_w@mail.gmail.com>
 <0473526e-df0a-94a5-5c22-debd0084ab16@ti.com>
 <36369388-e9c8-22cd-8c19-e2bdf2d0389b@ti.com>
 <eb2eb1f6-3c9b-7ecb-667e-819033af9c14@ti.com>
 <23eba53a-9304-2ceb-d97e-01891ec0b3ed@ti.com>
 <cb028b1e-05ca-9b22-be5d-c63f5fd56cc4@ti.com>
 <CAHCN7xLKL42ib4t0Lte3sJPoJrKX0TPJR9VWi+uW=fZjUg1ssg@mail.gmail.com>
 <c816d70d-fa5b-a43f-ae7a-6df4589fe484@ti.com>
 <CAHCN7xKKNpQwWZkg-JBncp9=VOcLJFEkcvST=rZqv-i9+5_Q2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xKKNpQwWZkg-JBncp9=VOcLJFEkcvST=rZqv-i9+5_Q2g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 30/09/2019 16:17, Adam Ford wrote:

>>> It looks like it's unhappy that its trying to get one frequency and
>>> getting something different instead.
>>>
>>> [   10.014099] WARNING: CPU: 0 PID: 111 at
>>> drivers/gpu/drm/omapdrm/dss/dss.c:655 dss_set_fck_rate+0x70/0x90
>>> [omapdss]
>>> [   10.014129] clk rate mismatch: 27870968 != 27000000
>>
>> I believe this one is for Tomi to comment, his driver does some magic
>> compares for the requested vs. actual received clock rates. If I am not
>> mistaken, we are only modifying an integer divider here, and thus it is
>> physically impossible to get accurate 27MHz rate to display.
> 
> I didn't expect exactly 27MHz,but the back trace is what concerns me more.

Ah sorry... DSS driver knows the max divider value, so that it can 
iterate over all the rates to find a good one.

I'll send a patch later, but look for omap3630_dss_feats in dss.c, and 
change fck_div_max from 32 to 16.

> However, looking at
> # cat clk/dpll4_ck/clk_rate
> 864000000
> 
> It seems like 864000000 / 32 would be 27 MHz, but instead we're
> dividing it by 31 yielding 27870968.  I don't know the clocking
> architecture, so I don't know what your patch actually did or how the
> divide by 16 limit worked into this.  If lck cannot divide by 32, it
> would be nice to see if it could divide by 27 to get to 32MHz.  From
> there, the pck could then divide by 4 yielding 9MHz.

That's pretty odd. With Tero's patch (I didn't test it though) the max 
divider should be 16. So the minimum fclk rate should be 54MHz. But 
somehow the clock framework managed to produce 27870968...

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
