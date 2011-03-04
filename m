From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 3/4] OMAP3 and 4 i2c mark extended reg enums as extended
 only
Date: Fri, 04 Mar 2011 08:32:01 +0000
Message-ID: <4D70A381.50409@linaro.org>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135037.30648.90406.stgit@otae.warmcat.com> <4D700917.70105@ti.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40216 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1CDIcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 03:32:04 -0500
Received: by wyg36 with SMTP id 36so1864828wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 00:32:03 -0800 (PST)
In-Reply-To: <4D700917.70105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Andy Green <andy@warmcat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>

On 03/03/2011 09:33 PM, Somebody in the thread at some point said:

Hi -

> Since it is a patch on the I2C driver, the subject should start with
> something like "I2C: OMAP2+: XXXXX". That comment is also applicable for
> the other patches of the series except the first one.
>
>> This patch changes the extended register name to make it clearer
>> they only exist in OMAP4 context
>>
>> Cc: patches@linaro.org
>> Reported-by: Peter Maydell<peter.maydell@linaro.org>
>> Signed-off-by: Andy Green<andy.green@linaro.org>
>
> The I2C maintainer should be in CC as well.

OK thanks for this correction.

>> + /* only on OMAP4430 */
>> + OMAP_I2C_OMAP4430_REVNB_LO,
>> + OMAP_I2C_OMAP4430_REVNB_HI,
>> + OMAP_I2C_OMAP4430_IRQSTATUS_RAW,
>> + OMAP_I2C_OMAP4430_IRQENABLE_SET,
>
> I think that you should keep only the comment, because it is not really
> recommended to add SoC related information directly in IP register names.
> These new registers are just an evolution of the I2C IP. The first
> instances of that version are used in OMAP4 first, but OMAP4 variants
> (4440) and OMAP5 will use the same one.
>
> Bottom line is that we can probably drop that patch from the series.

The desire of this patch is to make it clear to the eye that a register 
that was introduced in what we will now call "IP_V2" is being touched. 
That is good because then code like

	if (dev->rev == BLAH_IP_V1)
		touch(BLAH_BLAH_IP_V2);

will stand out clearly as wrong.  So I will update the patch rather than 
drop it, since the IP_Vn scheme is a much better fit for what is 
actually being done.  If you still don't like it we can forget about it 
then.

-Andy

