From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP: Change all cpu_is_* occurences to soc_is_*
Date: Wed, 2 Sep 2015 05:51:01 +0530
Message-ID: <55E640ED.6070004@ti.com>
References: <1440561575-3740-1-git-send-email-j-keerthy@ti.com> <55E5DE12.6070407@ti.com> <20150901180347.GO4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150901180347.GO4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org



On Tuesday 01 September 2015 11:33 PM, Tony Lindgren wrote:
> * Keerthy <a0393675@ti.com> [150901 10:22]:
>>
>>
>> On Wednesday 26 August 2015 09:29 AM, Keerthy wrote:
>>> Currently apart from dra7, omap5 and amx3 all the other SoCs
>>> are identified using cpu_is_* functions which is not right since
>>> they are all SoCs(System on Chips). Hence changing the SoC
>>> identification code to use soc_is instead of cpu_is and keeping
>>> defines for cpu_is where needed. This allows us to replace the
>>> rest of cpu_is usage along with other fixes as needed.
>>
>> Tony,
>>
>> A Gentle ping on this.
>
> Looks good to me for v4.4. I'll apply it after some testing
> after -rc1.

Thanks Tony.

>
> Regards,
>
> Tony
>
