From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v5] rtc: omap: Support ext_wakeup configuration
Date: Wed, 14 Sep 2016 11:21:48 +0200
Message-ID: <eb67e85b-4651-33e0-abb7-339d83f36463@grinn-global.com>
References: <201609082240.a4dMqCnB%fengguang.wu@intel.com>
 <4512fa0b-890b-0f10-00dd-188fcc98fb5c@grinn-global.com>
 <20160913215837.xstx4c6d4pr42hgh@piout.net>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <rtc-linux+bncBD7N3SEV2QCRBNNN4S7AKGQEKB2G3HY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160913215837.xstx4c6d4pr42hgh-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 13.09.2016 23:58, Alexandre Belloni wrote:
> Hi,
>
> On 12/09/2016 at 11:01:05 +0200, Marcin Niestroj wrote :
>> I guess we are missing PINCTRL in Kconfig. I didn't add that before,
>> because I thought that there is a dependency chain GENERIC_PINCONF ->
>> PINCONF -> PINCTRL.
>>
>> So to resolve this issue:
>> 1) Should we add "select" or "depends on" for PINCTRL?
>> 2) Should this option be somehow related to COMPILE_TEST?
>>
>
> Adding a "depends on PINCTRL" line should be enough to solve that issue.
>

Ok, will add that together with "depends on OF", as I noticed it is
also needed.


But right now we will not be able to compile this driver with
COMPILE_TEST, unless we select some architecture that selects PINCTRL.

So maybe it is a good idea to change "config PINCTRL" option from
'bool' to 'bool "Support PINCTRL" if COMPILE_TEST', so we can enable it
manually?

-- 
Marcin Niestroj

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
