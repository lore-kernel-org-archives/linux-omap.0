From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 1/4] OMAP3 and 4 hwmod I2C units only allow 16 bit access
Date: Fri, 04 Mar 2011 08:33:36 +0000
Message-ID: <4D70A3E0.6030509@linaro.org>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135022.30648.8996.stgit@otae.warmcat.com> <4D6FD2F2.8050701@ti.com> <4D6FD63C.6000102@linaro.org> <4D6FFCC0.8000007@ti.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63890 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758526Ab1CDIdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 03:33:40 -0500
Received: by wwb22 with SMTP id 22so2419749wwb.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 00:33:39 -0800 (PST)
In-Reply-To: <4D6FFCC0.8000007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, paul Walmsley <paul@pwsan.com>

On 03/03/2011 08:40 PM, Somebody in the thread at some point said:

Hi -

>>> BTW, It will be good if you could update the omap_hwmod_2430_data.c file
>>> as well.
>>
>> I left it because I can't test it, but I'll happily do it additionally
>> if you can test it on some OMAP2 hardware.
>
> Don't hesitate to do it, and clearly add in the cover-letter that it was
> tested on 3430 and 4430 only.
> Someone from TI should be able to test it on 2430.

Alright I will extend the patch series to cover 2430 for this and note 
it is untested.

-Andy
