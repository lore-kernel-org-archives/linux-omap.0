From: =?UTF-8?Q?Andr=c3=a9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH v2 1/2] ARM: dts: Move interconnect target module for
 omap3 sgx to separate dtsi files
Date: Thu, 2 Jan 2020 22:15:13 +0100
Message-ID: <9e39831c-bfa8-d497-7d3e-ff6ec04b8e52@dawncrow.de>
References: <20191230202037.28836-1-nerv@dawncrow.de>
 <20200102193359.GE16702@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102193359.GE16702@atomide.com>
Content-Language: de-LU
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Am 02.01.20 um 20:33 schrieb Tony Lindgren:
> * André Hentschel <nerv@dawncrow.de> [191230 20:22]:
>> Only dm3730 and am3715 come with SGX support
> 
> AFAIK dm3730 is just a marketing name for a catalog version of
> omap3630. So using omap36xx.dtsi is correct and we should not
> change that.
> 
> Can you please just add a minimal dm3725.dtsi that your board dts
> can include and avoid disabling sgx in the board specific file?
> That is assuming you have dm3725 with dsp and isp but no sgx.

I removed the sgx disable part already in 2/2.
Consulting my table:
     DM3730 | DM3725 | AM3715 | AM3703
DSP    X    |   X    |        |    
SGX    X    |        |   X    |    
Where X is "supported"

So including omap63xx.dtsi seems right after this patch moves the
sgx part to separate dtsi. Or do you want to have the sxg
disabling in the dm3725.dtsi?

> You can read the detected SoC with:
> 
> # cat /sys/bus/soc/devices/soc0/machine

# cat /sys/bus/soc/devices/soc0/machine
DM3725
# cat /sys/bus/soc/devices/soc0/revision 
ES1.2
