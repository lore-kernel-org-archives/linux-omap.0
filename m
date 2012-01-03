From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/2] mt_ventoux: support for TeeJet Mt.Ventoux board
Date: Tue, 03 Jan 2012 11:48:06 +0200
Message-ID: <4F02CED6.8090709@compulab.co.il>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com> <1324940912-18164-3-git-send-email-yanok@emcraft.com> <4EF97A41.7050605@compulab.co.il> <4EFA4E9C.30307@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:52819
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751185Ab2ACJsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 04:48:22 -0500
In-Reply-To: <4EFA4E9C.30307@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sasha_d@emcraft.com

Hi Ilya,

On 12/28/11 01:02, Ilya Yanok wrote:
> On 27.12.2011 11:56, Igor Grinberg wrote:
>>> +/*
>>> + * use fake regulator for vdds_dsi as we can't find this pin inside
>>> + * AM3517 datasheet.
>>> + */
>>> +static struct regulator_consumer_supply mt_ventoux_vdds_dsi_supply[] = {
>>> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
>>> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
>>> +};
>>
>> Although the TRM states that there is a vdds_dsi signal,
>> it looks, from the datasheet, that VDDSHV is used to power the DSS.
>> Either way, it can't be switched off, I think...
>> Therefore, depending on your board wiring, you can leave it as fixed
>> regulator or bind to a supply on TPS65023.
> 
> I will forward this info to hardware guys and ask about wiring. For now
> I will leave it as is. Thanks for this information it turned to be some
> kind of mystery. It would be great if you could give some pointer to the
> datasheet regarding VDDSHV and DSS.

Well, there is no direct pointer to that information, but
I've found these facts:
1) the "Ball Characteristics" tables state that the DSS related pins
   (and also many others) are powered by the VDDSHV.
2) the estimated power consumption of VDDSHV is the largest after the
   VDD_CORE, which is typical for DSS, but it is also one of the largest
   power domains, so I guess this cannot be a valid argument ;-)
3) On the "Voltage domains" diagram, only the VDD_CORE is exposed and
   DSS is not listed in it, but there are other domains which are not
   exposed... (this only can exclude the DSS from VDD_CORE, but not
   absolutely, as datasheets can have mistakes or just not give that piece
   of information).

Still, it is a guess and not verified information.

[...]

-- 
Regards,
Igor.
