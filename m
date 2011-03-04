From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] OMAP3 and 4 hwmod I2C units only allow 16 bit access
Date: Fri, 4 Mar 2011 11:05:46 +0100
Message-ID: <4D70B97A.7000200@ti.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135022.30648.8996.stgit@otae.warmcat.com> <4D6FD2F2.8050701@ti.com> <4D6FD63C.6000102@linaro.org> <4D6FFCC0.8000007@ti.com> <4D70A3E0.6030509@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49600 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab1CDKFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 05:05:52 -0500
In-Reply-To: <4D70A3E0.6030509@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "andy.green@linaro.org" <andy.green@linaro.org>
Cc: Andy Green <andy@warmcat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, paul Walmsley <paul@pwsan.com>

On 3/4/2011 9:33 AM, Andy Green wrote:
> On 03/03/2011 08:40 PM, Somebody in the thread at some point said:
>
> Hi -
>
>>>> BTW, It will be good if you could update the omap_hwmod_2430_data.c file
>>>> as well.
>>>
>>> I left it because I can't test it, but I'll happily do it additionally
>>> if you can test it on some OMAP2 hardware.
>>
>> Don't hesitate to do it, and clearly add in the cover-letter that it was
>> tested on 3430 and 4430 only.
>> Someone from TI should be able to test it on 2430.
>
> Alright I will extend the patch series to cover 2430 for this and note
> it is untested.

Cool, thanks for that.
Benoit
