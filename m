From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 00/23] ARM: dts: omap: Remove skeleton.dtsi usage and fix
 memory node DTC warning"
Date: Thu, 1 Sep 2016 10:46:22 +0200
Message-ID: <5d39188c-e4b4-5a84-fd95-55e3f5f7df4c@osg.samsung.com>
References: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
 <20160831142443.yevd4c6wldrprxrl@atomide.com>
 <20160831175436.mkmwwu3zwyidbeov@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831175436.mkmwwu3zwyidbeov@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On 08/31/2016 07:54 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160831 07:26]:
>> * Javier Martinez Canillas <javier@osg.samsung.com> [160831 03:36]:
>>> Hello Tony,
>>>
>>> This series removes the usage of the skeleton.dtsi in all the OMAP dts,
>>> which allows to get rid of the DTC warnings about a mismatch between the
>>> memory nodes unit names and reg properties.
>>>
>>> Patches are pretty trivial and shouldn't cause functional changes AFAIK,
>>> but have been only built tested.
>>
>> OK will take a look today and make sure things stay working.
>>
>> Good to hear the solution is to remove the include of skeleton.dtsi,
>> I was wondering what we're going to do about those warnings.
> 
> Seems to boot just fine for me on various omap variants so
> applying all into omap-for-v4.9/dt thanks.
>

Great, thanks a lot for the help.
 
> Tony
> 

Best regards,
---
Javier Martinez Canillas
Open Source Group
Samsung Research America
