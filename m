From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Fri, 14 Sep 2012 15:54:50 +0530
Message-ID: <505305F2.4000602@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>  <1347611263.2559.44.camel@deskari> <1347612392.2559.54.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49469 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758977Ab2INKYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 06:24:43 -0400
In-Reply-To: <1347612392.2559.54.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 14 September 2012 02:16 PM, Tomi Valkeinen wrote:
> On Fri, 2012-09-14 at 11:27 +0300, Tomi Valkeinen wrote:
>> On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
>
>>> This series prepares the low level DISPC driver(dispc.c) to configure writeback
>>> registers. The aim is to reuse most of the code as most of its registers are
>>> like overlay or manager registers, and are configured in the same way in most
>>> cases. The first few patches rename dispc_ovl_* functions to dispc_plane_*
>>
>> I'm not sure if the renaming causes more confusion than clarity... It
>> kinda creates a mishmash of ovl/plane names, and the term "plane"
>> doesn't really sound like it's a base for both overlays and wb. Could we
>> consider the wb as a special case, and keep the ovl name for most of the
>> things and have "wb" used for wb specific things?
>
> And while WB is a combination of overlays and ovl managers, do you think
> it'd be difficult to consider WB as a special, extended overlay? So just
> call it an overlay, and consider it as an overlay with special features,
> at least inside dispc.c. We probably need to have it as a totally
> different entity from user's point of view (i.e. the list of overlays
> wouldn't return WB, etc).

Yes, we could do that within dispc.c, we would still need some manager 
like functions which set GO or ENABLE. But apart from that it should be 
okay.

I think for dispc.c in general, for future, it might be a good idea to 
represent each piece of HW(like scalar or color converter, or a timing 
FSM) as a little function/module, and construct 
overlay/writeback/manager out of those, it might be cleaner. However, 
this may be an overkill, and not needed much if there aren't any new 
blocks comprising of these little blocks.

Archit
