From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
Date: Sun, 18 Dec 2011 13:31:24 +0530
Message-ID: <4EED9DD4.3020506@ti.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com> <20111216195002.GL32251@atomide.com> <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com> <20111216204123.GM32251@atomide.com> <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com> <20111217002409.GB6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:52192 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814Ab1LRIBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Dec 2011 03:01:30 -0500
Received: by mail-iy0-f178.google.com with SMTP id f6so8321927iag.37
        for <linux-omap@vger.kernel.org>; Sun, 18 Dec 2011 00:01:29 -0800 (PST)
In-Reply-To: <20111217002409.GB6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Saturday 17 December 2011 05:54 AM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [111216 12:27]:
>> Hi
>>
>> On Fri, 16 Dec 2011, Tony Lindgren wrote:
>>
>>> * Paul Walmsley <paul@pwsan.com> [111216 11:45]:
>>>> On Fri, 16 Dec 2011, Tony Lindgren wrote:
>>>>
>>>>> * Paul Walmsley <paul@pwsan.com> [111216 01:24]:
>>>>>
>>>>>> Shubhrajyoti D (2):
>>>>>>       ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
>>>>>>       ARM: OMAP: I2C: Reset support
>>>>>>
>>>>> Can you please update shi to leave out the extra callback
>>>>> function int (*device_reset) (struct device *dev) as I'd
>>>>> rather see that happen with pm_runtime calls?
>>>> What PM runtime call is used to reset a device?
>>> Hmm how about pm_runtime_disable? Or do we need a new
>>> call for reset?
> Meanwhile as Paul pointed out, we still need the device_reset
> pointer, so pulling in this series into i2c branch.
>  
>> Looking at the last few hunks of:
>>
>> http://marc.info/?l=linux-omap&m=132377389204328&w=2
>>
>> it appears to me that the driver needs to reset the device while it's 
>> still active & powered on, etc.
>>
>> Shubhrajyoti, care to comment further?
The driver does a reset in the error path.
Since we are not supposed to access the sysc reg the function is needed.
>>
>> - Paul

