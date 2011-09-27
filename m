From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 5/9] regulator: helper routine to extract fixed_voltage_config
Date: Tue, 27 Sep 2011 20:19:00 +0530
Message-ID: <4E81E25C.5080500@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-6-git-send-email-rnayak@ti.com> <20110927121622.GD4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56942 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1I0OtI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:49:08 -0400
Received: by mail-pz0-f42.google.com with SMTP id 1so17687881pzk.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:49:07 -0700 (PDT)
In-Reply-To: <20110927121622.GD4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tuesday 27 September 2011 05:46 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:48PM +0530, Rajendra Nayak wrote:
>> The helper routine of_get_fixed_voltage_config() extracts
>> fixed_voltage_config structure contents from device tree.
>>
>> Also add documenation for additional bindings for fixed
>> regulators that can be passed through dt.
>
> Why not just add device tree support into the driver directly?

Ok, will do.

>
>> +Optional properties:
>> +- regulator-fixed-supply: Name of the regulator supply
>
> This is going to be confusing with respect to the generic regulator
> supply property.

Yes, I guess. Any suggestions on how to make it less
confusing? :-)

>
>> +- regulator-fixed-enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
>
> Word wrap for legibility please.

Ok.

