From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 0/6] ARM: OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
Date: Mon, 20 May 2013 11:12:22 +0530
Message-ID: <5199B7BE.8060808@ti.com>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1305161831390.21357@utopia.booyaka.com> <87txm1smrz.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab3ETFnE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 May 2013 01:43:04 -0400
In-Reply-To: <87txm1smrz.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, nm@ti.com

On Friday 17 May 2013 07:59 PM, Kevin Hilman wrote:
> Hi Paul,
> 
> Paul Walmsley <paul@pwsan.com> writes:
> 
>> On Wed, 15 May 2013, Rajendra Nayak wrote:
>>
>>> OMAP UART IP needs manual idle modes based on functional state of the
>>> IP. Currently this is handled by the driver with function pointers
>>> implemented in platform code.
>>>
>>> This however breaks in case of device tree because of missing
>>> idle handling. 
>>>
>>> The series tries to address the issue and tries to remove complete
>>> sysc handling from serial driver.
>>
>> These look good to me.  Will queue them for v3.10-rc once they pass local 
>> testing here.
> 
> I reviewed and tested v2 of this (Rajendra forgot to add the tags in

Oops, sorry about that Kevin, and thanks for the repeated reviews and
tests on this series.

regards,
Rajendra

> v3) and also just sanity tested v3 of this on 4430/panda DT boot to
> verify the console issue is resolved.  Feel free to add:
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda
> 
> Kevin
> 

