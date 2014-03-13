From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v5] ASoC: tlv320aic31xx: Add basic codec driver implementation
Date: Thu, 13 Mar 2014 17:30:24 +0200
Message-ID: <5321CF10.3060702@ti.com>
References: <1394535452-17865-1-git-send-email-jsarha@ti.com> <20140313122007.GQ366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44029 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbaCMPaf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 11:30:35 -0400
In-Reply-To: <20140313122007.GQ366@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

On 03/13/2014 02:20 PM, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 12:57:32PM +0200, Jyri Sarha wrote:
>> This commit adds a bare bones driver support for TLV320AIC31XX family
>> audio codecs. The driver adds basic stereo playback trough headphone
>> and speaker outputs and mono capture trough microphone inputs.
>
> Applied, thanks.  One thing it'd be good to fix:
>
>> +Optional properties:
>> +
>> +- gpio-reset - gpio pin number used for codec reset
>> +- ai31xx-micbias-vg - MicBias Voltage setting
>
> This is optional but...
>
>> +	of_property_read_u32(np, "ai31xx-micbias-vg", &value);
>> +	switch (value) {
>> +	case MICBIAS_2_0V:
>> +	case MICBIAS_2_5V:
>> +	case MICBIAS_AVDDV:
>> +		aic31xx->pdata.micbias_vg = value;
>> +		break;
>> +	default:
>> +		dev_err(aic31xx->dev,
>> +			"Bad ai31xx-micbias-vg value %d DT\n",
>> +			value);
>> +		aic31xx->pdata.micbias_vg = MICBIAS_2_0V;
>> +	}
>
> ...you'll get an error if it's missing (and an uninitialised memory
> read).
>

Actually you don't. The value-variable is initialized to MICBIAS_2_0V 
and if "ai31xx-micbias-vg" is not present of_property_read_u32 leaves 
the variable untouched, but I'll send a patch for fixing the unused 
variable working shortly.

Forget about the v6 version of the patch.

Thanks,
Jyri

