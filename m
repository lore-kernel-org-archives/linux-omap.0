From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/5] arm: omap: counter-32k: convert to pm_runtime API
Date: Thu, 21 Oct 2010 13:17:47 -0700
Message-ID: <87zku7s3kk.fsf@deeprootsystems.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
	<1287480136-2046-3-git-send-email-balbi@ti.com>
	<87k4lbzbfg.fsf@deeprootsystems.com>
	<20101021190623.GV3958@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49098 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab0JUURu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 16:17:50 -0400
Received: by gxk3 with SMTP id 3so386387gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 13:17:50 -0700 (PDT)
In-Reply-To: <20101021190623.GV3958@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Thu, 21 Oct 2010 22:06:23 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <balbi@ti.com> writes:

> On Thu, Oct 21, 2010 at 12:46:11PM -0500, Kevin Hilman wrote:
>>Felipe Balbi <balbi@ti.com> writes:
>>
>>> Trivial patch removing clock framework and adding
>>> pm_runtime API.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>
>>Minor nit: the runtime PM 'put' calls do not need to be the _sync
>>versions.  You can easily get by using the "normal" (async) versions
>>here.
>
> Will change for next version, was just following what other drivers were
> doing.

You're right, I wasn't as picky about this before, but will be going
forward.  You're the lucky first victim. :)

Replacing clk_disable() with put_sync() is the correct functional
replacement, since clk_disable is immediate, ans so is put_sync.
However, since we have the option of a delayed disable now with runtime
PM, I think we should use it.

Kevin
