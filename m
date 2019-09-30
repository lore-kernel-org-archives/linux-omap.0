From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Mon, 30 Sep 2019 20:48:20 +0300
Message-ID: <6cd7c9f0-cb26-588b-dfd1-faf462732549@ti.com>
References: <20190510194229.20628-1-aford173@gmail.com>
 <845055e2-8182-de74-2077-629fdf50ac6c@ti.com>
 <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
 <854f6130-c8a8-81cb-aa76-4830f218ae54@ti.com>
 <CAHCN7xKocdiWOdmoWQV3POr84qte6WNt0QbQRAwxKSvU8COB_w@mail.gmail.com>
 <0473526e-df0a-94a5-5c22-debd0084ab16@ti.com>
 <36369388-e9c8-22cd-8c19-e2bdf2d0389b@ti.com>
 <eb2eb1f6-3c9b-7ecb-667e-819033af9c14@ti.com>
 <23eba53a-9304-2ceb-d97e-01891ec0b3ed@ti.com>
 <cb028b1e-05ca-9b22-be5d-c63f5fd56cc4@ti.com>
 <F3335195-6EB7-4D44-B884-2F29D9238011@goldelico.com>
 <CAHCN7xL9bFxO=2i1DzmRj6A3XwUNdt=DZeJ2a0EZ0f9gcFTy6g@mail.gmail.com>
 <CAHCN7x+vCfPTRE+zzYUwAXdbBzRotTP2hSOgsHB0FdgBhZV5zA@mail.gmail.com>
 <CAHCN7xJDV=R9Ysjhff7=mEXdciwPP_5LQbHwaUT8KvhSkLKw8A@mail.gmail.com>
 <04306a5e-f9be-35a4-1aa1-5795d780e289@ti.com>
 <3777f1b1-2d9a-334b-b9e7-99dfda2ae29b@ti.com>
 <CAHCN7xJNJca8W_yw5nNY3AmKDSPoLzJ8voPmR1HS3bNcU8uQGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xJNJca8W_yw5nNY3AmKDSPoLzJ8voPmR1HS3bNcU8uQGg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 30/09/2019 18:10, Adam Ford wrote:
> On Mon, Sep 30, 2019 at 9:27 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>> On 30/09/2019 17:20, Tomi Valkeinen wrote:
>>
>>> Let's see what Tero says, but yeah, something is odd here. I expected
>>> the max divider to be 16 with Tero's patch, but I don't see it having
>>> that effect. I can get the div to 31.
>>>
>>> You can see this from the clock register 0x48004e40 (CM_CLKSEL_DSS). The
>>> lowest bits are the divider, 5 to 0. The TRM says max div is 32.
>>>
>>> Tero said for him the dividers > 16 didn't "stick" to the register. I'm
>>> now wondering if he has an old beagleboard with OMAP34xx, which has max
>>> div 16.
>>
>> So testing a bit more here, I can see the DSS working fine and fps as
>> expected when I write values directly to CM_CLKSEL_DSS:5:0, with
>> dividers up to 31. With 32, DSS breaks. The TRM (AM/DM37x) says value 32
>> is valid.
> 
> I wonder if it's somehow being masked with bits 4:0 instead of 5:0
> which could potentially make the divider 0 and that value doesn't
> appear to be valid.

Hmmh, after some testing, it seems there is bad stuff happening with the 
divider clock implementation, I am re-working it as of now. Basically 
what is wrong is that with a divider max value of say 16, the driver 
attempts to craft the max value into a mask, but this ends up being 
0x1f. If the max value is 15, it ends up into 0xf which is correct.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
