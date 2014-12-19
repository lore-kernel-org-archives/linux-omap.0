From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods
 without sysc
Date: Fri, 19 Dec 2014 11:06:16 +0200
Message-ID: <5493EA88.1080609@ti.com>
References: <1418917790-1791-1-git-send-email-rogerq@ti.com> <5492F84E.7020706@ti.com> <5493B5CE.7010000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5493B5CE.7010000@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, tony@atomide.com, Paul Walmsley <paul@pwsan.com>
Cc: t-kristo@ti.com, nm@ti.com, nsekhar@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Lokesh,

On 19/12/14 07:21, Lokesh Vutla wrote:
> Hi Roger,
> On Thursday 18 December 2014 09:22 PM, Roger Quadros wrote:
>> Fixing up Paul's email id.
>>
>> cheers,
>> -roger
>>
>> On 18/12/14 17:49, Roger Quadros wrote:
>>> There are quite a few hwmods that don't have sysconfig register and so
>>> _find_mpu_rt_port(oh) will return NULL thus preventing ready state check
>>> on those modules after the module is enabled.
>>>
>>> This can potentially cause a bus access error if the module is accessed
>>> before the module is ready.
>>>
>>> Get rid of the redundant _find_mpu_rt_port() check from the _wait_target_ready()
>>> funcion for all the SoCs. The following PRCM register access that checks the
>>> module ready state has nothing to do with module's SYSCONFIG or mpu_rt_port.
> Yes, makes sense. This patch looks good to me.
> Tested this on AM437x-gp-evm.
> 
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks.

> 
> May be good idea to warn every time if enabling of module is failed?
> Unrelated to this patch though.

Yes, failing to be ready is serious enough for a warning. Care to send a separate patch for that?

cheers,
-roger
