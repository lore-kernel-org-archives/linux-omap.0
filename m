From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 17 Dec 2019 12:01:51 -0500
Message-ID: <8d5d098f-26cb-c436-ec7b-bed0ed0a9ced@ti.com>
References: <7fa11037-8d33-2274-c8cc-80e9630b38b0@ti.com>
 <20191119192029.GP35479@atomide.com>
 <0ad31b32-712e-5bef-5645-0336dfec99cc@ti.com>
 <20191119194425.GQ35479@atomide.com>
 <f2f53e5e-6c95-e32f-d67a-284bb88e73e0@ti.com>
 <1ff8ae4b-5de3-4fdf-7318-d33398dc7fc8@ti.com>
 <20191216210407.GR35479@atomide.com>
 <9adad579-98b4-f228-caf3-f4996dcaecda@ti.com>
 <20191216224105.GS35479@atomide.com>
 <35e4b682-0d2f-23b1-6df4-428c6bcb4d59@ti.com>
 <20191217150732.GW35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217150732.GW35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/17/19 10:07 AM, Tony Lindgren wrote:
> * Andrew F. Davis <afd@ti.com> [191217 13:14]:
>> On 12/16/19 5:41 PM, Tony Lindgren wrote:
>>> Please just add omap_early_initcall() to omap-secure.c while at it
>>> to deal with this.
>>
>> omap_early_initcall()s are not called until after all the SMC calls have
>> already happened.
> 
> Oh OK. Then let's just add omap_secure_init() that's called from
> *_init_early() as late as possible. We will have more use for that
> init later on too.
> 


You mean add a call to this omap_secure_init() to every boards init
function?

Andrew


> Regards,
> 
> Tony
> 
