From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/13] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Thu, 24 Jun 2010 10:48:59 -0700
Message-ID: <87sk4cfhis.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-3-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232254430.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42773 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab0FXRtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:49:03 -0400
Received: by pwj8 with SMTP id 8so1956896pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:49:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006232254430.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 23 Jun 2010 23:02:33 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> something doesn't make sense in this patch...
>
> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>
>> If an omap_hwmod is setup using HWMOD_INIT_NO_IDLE flag, there is
>> currently way to idle it since omap_hwmod_idle() requires the hwmod to
>> be in the enabled state.
>
> The only thing that HWMOD_INIT_NO_IDLE does is prevent the hwmod from 
> being idled at the end of _setup().  By that time, the hwmod has already 
> been enabled, and its state has been set to _HWMOD_STATE_ENABLED.  So 
> there shouldn't be anything preventing the hwmod from being idled at that 
> point?
>
> Maybe the problem is that some hwmods were failing _wait_target_ready() 
> and so were never entering the ENABLED state?  If so, that looks like it's 
> fixed appropriately by your patch 3.

Hmm, strange.  

Indeed, this patch predates patch 3, so may not be necessary anymore.  I will
check into it.

Kevin
