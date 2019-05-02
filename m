From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] ARM: dts: dra76x: Update MMC2_HS200_MANUAL1 iodelay
 values
Date: Thu, 2 May 2019 11:58:16 +0530
Message-ID: <9e32440f-cdab-eb79-2abb-9b0596701743@ti.com>
References: <20190430060856.18445-1-faiz_abbas@ti.com>
 <20190430155415.GI8007@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430155415.GI8007@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 30/04/19 9:24 PM, Tony Lindgren wrote:
> Hi,
> 
> * Faiz Abbas <faiz_abbas@ti.com> [190429 23:09]:
>> Update the MMC2_HS200_MANUAL1 iodelay values to match with the latest
>> dra76x data manual[1].
>>
>> Also this particular pinctrl-array is using spaces instead of tabs for
>> spacing between the values and the comments. Fix this as well.
> 
> Is this needed as a fix or can this wait?
> 

This is a fix. The new iodelay values will have better marginality and
should prevent issues in corner cases.

Thanks,
Faiz
