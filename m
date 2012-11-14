From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 1/3] ASoC: OMAP: HDMI: Update machine driver name
Date: Wed, 14 Nov 2012 11:00:54 -0600
Message-ID: <50A3CE46.8050207@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-2-git-send-email-ricardo.neri@ti.com> <50A36F98.7060103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60381 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2KNRBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 12:01:53 -0500
In-Reply-To: <50A36F98.7060103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Liam,

Thanks for reviewing!

On 11/14/2012 04:16 AM, Liam Girdwood wrote:
> On 14/11/12 02:30, Ricardo Neri wrote:
>> Being the name of a machine driver, it aims to describe the
>> connection between the HDMI IP of the processor and the companion
>> chip it uses to connect to the outside world. This name tries to
>> follow the same naming convention as in the OMAP-ABE-TWL6040
>> machine driver.
>>
>> TPD12S015 is an HDMI companion chip for DC-DC step-up, I2C level
>> shifter and low-capacitance ESD protection. This chip is used on
>> all OMAP4 Pandaboards an SDPs as well as in OMAP5 EVMs.
>>
>
> Is the TPD12S015 passive or actively controlled by the CPU in this
> case ?

Yes the CPU controls the TPD12S015 actively through two GPIOs. One GPIO
is used to enable data transfer. The second GPIO is enable the TPD to
detect cable connection. However, this abstracted by the OMAPDSS HDMI 
driver and the ASoC driver does not know about it.
>
> If it's passive then it's not really worth changing the driver name
> since other OMAP4/5 devices may use other HDMI companion chips (an we
>  can reuse this driver without changes).

I believe it would be good to change the name of the driver to describe 
better the machine. omap-hdmi-audio makes reference only to the 
processor and sounds good to reserve it for the CPU DAI driver. Maybe 
something more generic could be used if the ASoC driver will not control 
the companion chip. How about omap-hdmi-board-audio or 
omap-hdmi-machine-audio? omap-hdmi-[companion]-audio was the 
best-looking to me.

BR,

Ricardo

>
> Liam
