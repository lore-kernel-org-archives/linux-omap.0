From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
Date: Thu, 29 Nov 2018 17:51:43 -0600
Message-ID: <bc72c707-b4cc-8a02-6cfb-4d474f7fae03@ti.com>
References: <20181128220211.GA5037@lunn.ch>
 <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com> <20181129002835.GB5037@lunn.ch>
 <20181128.172212.1033397162837638079.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128.172212.1033397162837638079.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi All,

On 11/28/18 7:22 PM, David Miller wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Thu, 29 Nov 2018 01:28:35 +0100
> 
>> On Wed, Nov 28, 2018 at 04:43:40PM -0600, Grygorii Strashko wrote:
>>> Hi Andrew,
>>>
>>> On 11/28/18 4:02 PM, Andrew Lunn wrote:
>>>>> This is dynamic configuration related to ALE VLAN entries and
>>>>> I do not see the way to support its auto-detection with current driver,
>>>>> unfortunately.
>>>>
>>>> I think you can subscribe to switchdev events which will tell you.
>>>
>>> Thanks a lot for your review and comments.
>>>
>>> Unfortunately, we still do not have switchdev in place, but i need to resolve
>>> existing issue somehow. This patch is small, local to CPSW fix which can be
>>> backported to stable. So, if possible, and no strong objection, could we proceed with it?
>>
>> Hi Grygorii
>>
>> David is the person who generally says no to kernel module
>> parameters. You should ask him.
> 
> No module options.
> 
> You'll be stuck with it forever.

Thank you for your feedback.

-- 
regards,
-grygorii
