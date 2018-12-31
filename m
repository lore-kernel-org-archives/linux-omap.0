From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Mon, 31 Dec 2018 09:23:01 +0200
Message-ID: <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
 <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info>
 <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux>
 <20181228200229.GY6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181228200229.GY6707@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Andreas Kemnade <andreas@kemnade.info>
Cc: Stephen Boyd <sboyd@kernel.org>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

On 28/12/2018 22:02, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]:
>> Hi,
>>
>> On Tue, 4 Dec 2018 08:45:57 -0800
>> Tony Lindgren <tony@atomide.com> wrote:
>>
>>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
>>>> On Mon, 3 Dec 2018 07:39:10 -0800
>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>> The consumer device stays active just fine with PM runtime
>>>>> calls. So yes, the problem is keeping a clock controller forced
>>>>> active for the period of consumer device reset. Other than
>>>>> that typically autoidle can be just kept enabled.
>>>>>    
>>>> Are we still talking about the same problem? Maybe I am losing track
>>>> here. Just to make sure.
>>>> The patch series was about disabling autoidle for devices which cannot
>>>> work with it during normal operation. Not during reset or something
>>>> like that.
>>>> Or is the keep-clock-active-during-reset just a requirement for bigger
>>>> restructuring ideas?
>>>
>>> Yeah there are two issues: The fix needed for the issue you brought up,
>>> and also how to let a reset driver to block autoidle for reset.
>>>
>> Hmm, is this set now waiting for the famous "somebody" fixing all
>> the stuff?
> 
> Well I think we're still waiting on Tero to comment on this.

The only item requiring immediate fixing is the point Stephen made out, 
removing the usage of CLK_IS_BASIC from this patch.

Afaics, the reset related concerns Tony has can be handled later.

-Tero

> 
>> What are currently visible symptoms for the driver not blocking
>> autoidle for reset? Maybe I can at least test something there. I have
>> also omap5 here.
> 
> Oh that's just for making drivers/reset drivers to work in
> the long run. Let's keep that separate from these fixes..
> 
> Regards,
> 
> Tony
> 
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
