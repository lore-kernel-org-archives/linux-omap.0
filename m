From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 0/6] Add MCAN Support for dra76x
Date: Wed, 6 Jun 2018 15:43:53 +0530
Message-ID: <be94f43a-57a9-3e17-3753-9f53d854b42f@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606100937.GF5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606100937.GF5738@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 06 June 2018 03:39 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180606 06:09]:
>> The following patches add dts and sysconfig support
>> for MCAN on TI's dra76 SOCs
>>
>> The patches depend on the following series:
>> https://patchwork.kernel.org/patch/10221105/
>>
>> Changes in v3:
>>  1. Added reset functionality to the ti-sysc
>>     driver. This enables me to drop the hwmod
>>     data patch as everything is being done in dt.
>>
>>  2. Dropped ti,hwmods from the dts nodes
> 
> Cool good to hear that works :)
> 
>>  4. Removed the status="disabled" in dtsi
>>     followed by status="okay" in dts.
> 
> Hmm okay is the default and is not needed. I did not notice
> okay in this set based on a quick glance so maybe you already
> dropped it?

I guess that wasn't clear. I meant to say I have dropped both
status=disabled and status=okay because okay is default.

Thanks,
Faiz
