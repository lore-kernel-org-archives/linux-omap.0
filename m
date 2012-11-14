From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Wed, 14 Nov 2012 11:07:09 -0600
Message-ID: <50A3CFBD.5080903@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-4-git-send-email-ricardo.neri@ti.com> <20121114032712.GQ4415@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58147 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188Ab2KNRIJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 12:08:09 -0500
In-Reply-To: <20121114032712.GQ4415@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Mark,

Thanks for reviewing!				

On 11/13/2012 09:27 PM, Mark Brown wrote:
> On Tue, Nov 13, 2012 at 08:30:49PM -0600, Ricardo Neri wrote:
>> Instead of defining the address offset of the DMA port for transfers of
>> audio samples, obtain this information from the resources of the device.
>> This device and its resources are created by the OMAPDSS HDMI driver.
>
> Presumably this needs some other corresponding change in the resource
> setup to go in simultaneously...

Yes, the change in the resources setup has been submitted to the OMAPDSS 
HDMI driver and accepted by Tomi [1].

>
>> -	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
>> -		+ OMAP_HDMI_AUDIO_DMA_PORT;
>> +	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start;
>
> ...both before and after versions use the resource.

This change should be present in K3.8.
>

BR,

Ricardo

[1].http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79801.html
