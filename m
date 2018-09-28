From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
Date: Fri, 28 Sep 2018 11:48:28 -0500
Message-ID: <7fe653e5-a554-fe38-6183-217ebf474d48@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com> <20180926223612.GA32286@amd>
 <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com> <20180927214752.GG17346@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927214752.GG17346@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 09/27/2018 04:47 PM, Pavel Machek wrote:
> Hi!
> 
>>> Duplicate.
>>>
>>> Can we get some more sharing? One way would be to have struct with
>>> all the constants (instead of #defines) use that...?
>>
>> I will look at the adding common constants to but they should be common across
>> more then just 2 devices.  As you can see the LM3632 code is quite different
>> when you add in the flash/torch support.
> 
> LM3632 is indeed different, I see.
> 
> On the other hand, I'd really like to see the code shared, even if it
> is just for 2 devices. (I believe that family is big enough that we'll
> likely see more sharing in future).
> 

Yes I have been looking at the other drivers I created that support 11 bit and
I plan to move them over to call the common code if the code is accepted.

I just finished debugging and getting the 3632 and 3633 drivers working with
flash/torch and configurable indicator support and there is a lot of code
diff especially around the node parsing and configuration.

Dan

> Thanks,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
