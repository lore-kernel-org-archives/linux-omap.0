From: Archit Taneja <archit@ti.com>
Subject: Re: [pandaboard] omapfb not accepting 720p mode
Date: Mon, 28 Oct 2013 15:36:19 +0530
Message-ID: <526E371B.4060806@ti.com>
References: <526BE06E.4020704@math.uni-bielefeld.de> <526E05BE.8090808@ti.com> <526E2FC1.6030607@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab3J1KHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Oct 2013 06:07:12 -0400
In-Reply-To: <526E2FC1.6030607@math.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org

Hi,

On Monday 28 October 2013 03:04 PM, Tobias Jakobi wrote:
> Archit Taneja wrote:
>> The issue seems like we can't allocate buffers for 720p.
>>
>> Can you make sure if CONFIG_DMA_CMA is set in your config? And you
>> could set CMA_SIZE_MBYTES to a larger valuem say 50M.
>>
>> Archit
>>
> Hello Archit,
>
> yes, CMA is activated and with my latest config I've got 32MB allocated.
> I'll try to further increase the amount and check some other (larger)
> resolutions with don't require CVT (1280x1024 e.g.).
>
> Also I may be wrong, but isn't allocation done after the parsing?
> The first message "cannot parse default modes" comes from
> omapfb_parse_def_modes returning an error. Which could be triggered by
> either the mode syntax being messed up (not the case for me I think),
> kstrdup failing (not very likely) or omapfb_set_def_mode failing. And
> from what I can see, omapfb_set_def_mode does some timing
> calculations/conversions, sets these timings and nothing more.

You are right about the allocation coming after parsing the modes.

The problem is that our naming conventions for displays had changed 
sometime back. Could you change the name 'hdmi' to 'connector-hdmi', 
like below:

connector-hdmi:mode-string

Archit

