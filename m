From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 15/17] OMAPDSS: remove extra_info completion code
Date: Thu, 6 Sep 2012 19:31:32 +0530
Message-ID: <5048ACBC.8010502@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>   <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>   <50475444.2080509@ti.com> <1346936681.2737.61.camel@deskari>  <5048A6AA.50009@ti.com> <1346938926.2737.71.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab2IFOBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 10:01:21 -0400
In-Reply-To: <1346938926.2737.71.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 06 September 2012 07:12 PM, Tomi Valkeinen wrote:
> On Thu, 2012-09-06 at 19:05 +0530, Archit Taneja wrote:
>> On Thursday 06 September 2012 06:34 PM, Tomi Valkeinen wrote:
>>> On Wed, 2012-09-05 at 19:01 +0530, Archit Taneja wrote:
>>>> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
>>>>> Now that fifo merge has been removed, nobody uses the extra_info related
>>>>> completion code, which can be removed.
>>>>
>>>> I think this might come into use when we fix the usage of channel out
>>>> field. That is, since channel out is an immediate write field, when we
>>>> set a new manager for an overlay, we may need to wait till the overlay
>>>> disable kicks in, only then we should change channel out.
>>>>
>>>> For this, we would need some wait for extra_info, right?
>>>
>>> Hmm, yes, I think you are right. Previously the ovl_disable waited until
>>> the overlay is not used anymore, but now it doesn't.
>>>
>>> So I think I need to add wait_pending_extra_info_updates() call to the
>>> beginning of dss_ovl_set_manager(). Or, should it be in unset_manager...
>>> I think unset is better, then a "free" overlay always disabled also in
>>> the HW level.
>>
>> Yes, I also think it should be in unset_manager. One option could be to
>> leave the wait_pending_extra_info_updates() in ovl_disable itself, as it
>> was before. But that would force us to use mutexes there, and we'd
>> rather have overlay enabling and disabling as a non blocking thing.
>
> Actually, we do have mutexes there. You are thinking about the prototype
> API I have. (I also thought we didn't have mutex there =).

Ah, I missed looking at that :)

>
> So, in fact, we can have the wait at ovl_disable like it was before. The
> prototype API, which cannot block, will not have the wait, but there the
> caller (i.e. omapdrm) will have to manage the proper wait.

I'm more inclined towards waiting in the unset_manager() now, we have a 
choice between "wait in ovl_disable, ensure the overlay is actually 
disabled in hw, and then get out" and "wait only when you know you need 
to wait (i.e, in unset_manager)". The second choice seems more efficient.

This wait would could last for a 1 VSYNC if we do it in ovl_disable. If 
the next task of the user of DSS is to enable another overlay, this wait 
would unnecessarily delay the enabling of the second overlay by a VSYNC. 
We could have done these tasks in the same VSYNC (since we aren't 
supporting fifomerge).

So, I feel that we should rather wait in unset_manager, where we know an 
immediate write can mess things up. Maybe, we could delay it set_manager 
too. But yeah, we won't know whether we are aligned with hw or not.

So even with the prototype API, where omapdrm is responsible for doing 
the waiting, it should probably wait when switching the manager, rather 
than when disabling the overlay.

Archit

