From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Fri, 27 Sep 2019 18:37:35 +0300
Message-ID: <36369388-e9c8-22cd-8c19-e2bdf2d0389b@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0473526e-df0a-94a5-5c22-debd0084ab16@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Adam Ford <aford173@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 27/09/2019 16:47, Tomi Valkeinen wrote:
> On 27/09/2019 15:33, Adam Ford wrote:
> 
>>> It looks like a bug in omap clock handling.
>>>
>>> DSS uses dss1_alwon_fck_3430es2 as fclk. dss1_alwon_fck_3430es2 comes
>>> from dpll4_ck, and there's a divider after the PLL, dpll4_m4_ck.
>>>
>>> When the DSS driver sets dss1_alwon_fck_3430es2 rate to 27000000 or
>>> 27870967, which can be created with m4 dividers 32 and 31, it looks like
>>> the divider goes to bypass, or to a very small value. DSS gets a very
>>> high clock rate and breaks down.
>>
>> Is there anything I can do to help troubleshoot this?  I could insert
>> a hack that checks if we're omap3 and if so make the divider equal to
>> 4, but that seems like just a hack.
>> I can run more tests or insert code somewhere if you want.
> 
> I think it's up to someone who's knowledgeable in omap clock framework. 
> I'm kind of hoping that Tero or Tony would be willing to debug =). I can 
> try to find time to debug the omap clk framework, but I'll be going on 
> blindly there.

If you can provide details about what clock framework / driver does 
wrong (sample clk_set_xyz call sequence, expected results via 
clk_get_xyz, and what fails), I can take a look at it. Just reporting 
arbitrary display driver issues I won't be able to debug at all (I don't 
have access to any of the displays, nor do I want to waste time 
debugging them without absolutely no knowledge whatsoever.)

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
