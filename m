From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v3 0/7] ARM: dts: AM43x: Add devcice tree nodes
Date: Thu, 10 Jul 2014 18:55:22 +0530
Message-ID: <53BE9442.4070101@ti.com>
References: <1404884193-20580-1-git-send-email-j-keerthy@ti.com> <20140709083114.GH28884@atomide.com> <53BD208E.6000507@ti.com> <20140709115106.GV28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709115106.GV28884@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, broonie@kernel.org
Cc: Keerthy <j-keerthy@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 July 2014 05:21 PM, Tony Lindgren wrote:
> * Keerthy <a0393675@ti.com> [140709 04:03]:
>> On Wednesday 09 July 2014 02:01 PM, Tony Lindgren wrote:
>>> * Keerthy <j-keerthy@ti.com> [140708 22:40]:
>>>> The patch series adds the device tree nodes and the corresponding
>>>> documentation. The series also enabled tps65218 config options
>>>> in the omap2plus_defconfig.
>>>>
>>>> The series is boot tested on both AM43x-epos-evm and AM437x-gp-evm.
>>> Are the .dts changes safe to apply separately without breaking
>>> anything?
>> Tony,
>>
>> Patch 1/7 had to be re-based on Mark's latest branch for tps65218.
>> Other patches can be taken as is. These patches are boot tested on
>> both am437x-gp-evm and am43x-epos-evm.
> OK thanks applying patches 4 - 7 into omap-for-v3.17/dt.
>
> Tony

Thanks Tony.

Mark,

Could you please pull patch 2 and patch 3? The documentation is missing.

Kind Regards,
Keerthy
