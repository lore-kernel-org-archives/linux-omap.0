From: Archit Taneja <archit@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 17:22:37 +0530
Message-ID: <50D1AA85.1000207@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net> <50D1A2BC.4040605@ti.com> <50D1A34B.8030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52254 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab2LSLxE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 06:53:04 -0500
In-Reply-To: <50D1A34B.8030308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-omap@vger.kernel.org

On Wednesday 19 December 2012 04:51 PM, Tomi Valkeinen wrote:
> On 2012-12-19 13:19, Tomi Valkeinen wrote:
>> On 2012-12-19 12:51, Peter Meerwald wrote:
>>> Hello,
>>>
>>>> In the case we set it to 4, the DISPC_FCLK is fast enough to do the required
>>>> downscaling, but in the case when it's set to 0, it might need to pre decimate
>>>> rather than try to scale.
>>>
>>> this is my understanding as well
>>>
>>>>> I think there is a bug downscaling YUV data when resorting to
>>>>> pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a workaround
>>>>> -- any ideas how this can be fixed?
>>>
>>>> Pre-decimation should work for YUV formats also. Could you share DISPC reg
>>>> dumps when this happens:
>>>>
>>>> mount -t debugfs debugfs /sys/kernel/debug
>>>> cat /sys/kernel/debug/omapdss/dispc
>>>
>>> please find the files http://pmeerw.net/ok.dispc (with FCK_PER_PCK=4) and
>>> http://pmeerw.net/fail.dispc (FCK_PER_PCK=0)
>>
>> Something funny is going on here. I can reproduce on omap3 with a few
>> hacks that reduce the clocks. The PICTURE_SIZE's width field is
>> different for working and non-working cases, but I think it should be
>> the same for both.
>
> Ah, never mind. Of course the picture_size needs to be modified if
> predecimation is used...

You said that you see the issue with RGB too. Did you mean the 
picture_size, or visually also?

One thing I'm guessing is that DMA fetching with predecimation isn't 
really optimised for omap3, if the pixel clock in Peter's setup is high, 
the DISPC DMA might not be able to fetch pixels fast enough in 
predecimation case. That sort of supports the possibility of a skewed 
image seen.

Peter,

Do you see any SYNC_LOST or UNDERFLOW prints when this happens?

Archit
