From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
Date: Tue, 15 May 2018 11:34:16 +0530
Message-ID: <b4d95a08-82fd-9f39-53e7-977351788c88@ti.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
 <20180501152615.GB98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501152615.GB98604@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 01 May 2018 08:56 PM, Tony Lindgren wrote:
> Hi,
> 
> * Faiz Abbas <faiz_abbas@ti.com> [180408 09:59]:
>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Add MCAN hwmod data and register it for dra762 silicons.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 62352d1..a2cd7f8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1356,6 +1356,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
>>  };
>>  
>>  /*
>> + * 'mcan' class
>> + *
>> + */
>> +static struct omap_hwmod_class dra76x_mcan_hwmod_class = {
>> +	.name	= "mcan",
>> +};
> 
> Looks like you're missing the related struct omap_hwmod_class_sysconfig
> entry for this with the rev and sysconfig registers.
> 

Sorry, I missed this email earlier. The MCAN module doesn't have
sysconfig registers.

Thanks,
Faiz
