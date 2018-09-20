From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Date: Thu, 20 Sep 2018 10:11:08 +0300
Message-ID: <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
References: <20180822090319.29167-1-johan@kernel.org>
 <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 31/08/18 00:46, Stephen Boyd wrote:
> Quoting Johan Hovold (2018-08-22 02:03:19)
>> Fix child-node lookup which by using the wrong OF helper was searching
>> the whole tree depth-first, something which could end up matching an
>> unrelated node.
>>
>> Also fix the related node-reference leaks.
>>
>> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> ---
> 
> Applied to clk-next
> 

Stephen, this patch causes a merge conflict with some of the code I am 
planning to send a pull-req against (the clkctrl work series: 
https://patchwork.kernel.org/project/linux-clk/list/?series=13841)

Would it be possible to drop this from clk-next, and for me to 
pick-it-up via my own branch? I can get this setup either today or tomorrow.

Alternatively I need an immutable branch against which I can work.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
