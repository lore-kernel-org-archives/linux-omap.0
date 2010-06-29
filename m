From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/13] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Tue, 29 Jun 2010 14:47:30 -0700
Message-ID: <87iq51o6j1.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-3-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232254430.1550@utopia.booyaka.com>
	<87sk4cfhis.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53677 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab0F2Vrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 17:47:35 -0400
Received: by pvc7 with SMTP id 7so65869pvc.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 14:47:34 -0700 (PDT)
In-Reply-To: <87sk4cfhis.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 24 Jun 2010 10:48:59 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Paul Walmsley <paul@pwsan.com> writes:
>
>> Hi Kevin,
>>
>> something doesn't make sense in this patch...
>>
>> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>>
>>> If an omap_hwmod is setup using HWMOD_INIT_NO_IDLE flag, there is
>>> currently way to idle it since omap_hwmod_idle() requires the hwmod to
>>> be in the enabled state.
>>
>> The only thing that HWMOD_INIT_NO_IDLE does is prevent the hwmod from 
>> being idled at the end of _setup().  By that time, the hwmod has already 
>> been enabled, and its state has been set to _HWMOD_STATE_ENABLED.  So 
>> there shouldn't be anything preventing the hwmod from being idled at that 
>> point?
>>
>> Maybe the problem is that some hwmods were failing _wait_target_ready() 
>> and so were never entering the ENABLED state?  If so, that looks like it's 
>> fixed appropriately by your patch 3.
>
> Hmm, strange.  
>
> Indeed, this patch predates patch 3, so may not be necessary anymore.  I will
> check into it.
>

Just to update... this patch is no longer needed.  Dropping from the
series and an updated pm-hwmods branch has been pushed.

Kevin
