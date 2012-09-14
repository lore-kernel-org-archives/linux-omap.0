From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Fri, 14 Sep 2012 15:43:59 +0530
Message-ID: <50530367.5030303@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com> <1347611263.2559.44.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50048 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759324Ab2INKNw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 06:13:52 -0400
In-Reply-To: <1347611263.2559.44.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 14 September 2012 01:57 PM, Tomi Valkeinen wrote:
> On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
>> DSS HW on OMAP4 onwards supports a new pipeline called writeback. Unlike other
>> pipelines(called overlays in OMAPDSS), writeback takes pixel data from an
>> overlay output or a overlay manager output and writes it back into a specified
>> address in memory.
>>
>> writeback pipeline allows us to take benefit of the hardware processing
>> available inside the DISPC like color space conversion, rescaling, compositing
>> etc and do either a) perform memory-to-memory transfer with data processing,
>> b) capture a displayed frame. The former is known as memory to memory mode of
>> the writeback pipeline, and the latter is known as capture mode. More details
>> about writeback can be found in the Display Subsystem section of the OMAP4/5 TRMs.
>>
>> witeback has properties of both overlays and overlay managers. It is like an
>> overlay as it has programmable base addresses and contains blocks like scalar,
>
> You consistently use the term "scalar" in the patches, but I believe the
> correct term is "scaler".

Yes, my bad, I'll fix this.

>
>> color conversion unit, truncation unit, DISPC DMA FIFO. It is like a manager as
>> enabling it immediately starts transfer to the memory, and it has a GO bit to use
>> a new writeback configuration.
>>
>> This series prepares the low level DISPC driver(dispc.c) to configure writeback
>> registers. The aim is to reuse most of the code as most of its registers are
>> like overlay or manager registers, and are configured in the same way in most
>> cases. The first few patches rename dispc_ovl_* functions to dispc_plane_*
>
> I'm not sure if the renaming causes more confusion than clarity... It
> kinda creates a mishmash of ovl/plane names, and the term "plane"
> doesn't really sound like it's a base for both overlays and wb. Could we
> consider the wb as a special case, and keep the ovl name for most of the
> things and have "wb" used for wb specific things?

I initially kept all of this the same, but I changed my mind at some 
point, not totally sure why. Even if we stick to the dispc_ovl_* names, 
we would still need to create q common function which dispc_ovl_setup() 
and dispc_wb_setup() could call. I called this dispc_plane_setup(), and 
then it felt weird to call everything else ovl specifuic, hence renamed 
all of them to dispc_plane_*.

Could you suggest a better name than dispc_plane_setup?

>
>> functions. The next few patches change how overlay caps are used within the
>> dispc functions, this helps reusing more functions between overlays and
>
> I dislike this a bit, I think dispc driver should know what HW it has,
> you shouldn't need to pass caps to it. So I'd prefer the dispc driver to
> to have this information in dispc_features. I believe all OVL_CAPS
> should be there, and then exported to other drivers via some means. I
> guess this means could for now be just initializing ovl->caps with data
> from dispc.c.

Currently, we pass the plane id to these low level functions, it 
extracts out the ovl struct usingthe plane id, and checks the ovl caps.

What I'm doing now is just passing the caps directly to these low level 
functions. So that I don't need to have complicated checks in every 
function to extract caps between overlays or writeback.

Archit

>
>   Tomi
>

