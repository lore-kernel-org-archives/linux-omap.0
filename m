From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/9] regulator: twl: Remove hardcoded board constraints
 from driver
Date: Tue, 27 Sep 2011 20:17:28 +0530
Message-ID: <4E81E200.4030505@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-2-git-send-email-rnayak@ti.com> <20110927113719.GH2910@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48027 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770Ab1I0Ori (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:47:38 -0400
Received: by mail-vw0-f54.google.com with SMTP id 11so8528130vws.41
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:47:37 -0700 (PDT)
In-Reply-To: <20110927113719.GH2910@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tuesday 27 September 2011 05:07 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:44PM +0530, Rajendra Nayak wrote:
>> Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
>> each regulator from the twl driver and let the boards pass it.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
>
>> -	/* Constrain board-specific capabilities according to what
>> -	 * this driver and the chip itself can actually do.
>> -	 */
>> -	c =&initdata->constraints;
>> -	c->valid_modes_mask&= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
>> -	c->valid_ops_mask&= REGULATOR_CHANGE_VOLTAGE
>> -				| REGULATOR_CHANGE_MODE
>> -				| REGULATOR_CHANGE_STATUS;
>
> This isn't actually hard coding constraints, this is restricting the
> constraints passed in further rather than adding new ones.
>
> However should be fine:
>
> Acked-by: Mark Brown<broonie@opensource.wolfsonmicro.com>

Thanks.
