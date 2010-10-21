From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] arm: omap: counter-32k: convert to pm_runtime API
Date: Thu, 21 Oct 2010 22:06:23 +0300
Message-ID: <20101021190623.GV3958@legolas.emea.dhcp.ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
 <1287480136-2046-3-git-send-email-balbi@ti.com>
 <87k4lbzbfg.fsf@deeprootsystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56707 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab0JUTG1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Oct 2010 15:06:27 -0400
Content-Disposition: inline
In-Reply-To: <87k4lbzbfg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Oct 21, 2010 at 12:46:11PM -0500, Kevin Hilman wrote:
>Felipe Balbi <balbi@ti.com> writes:
>
>> Trivial patch removing clock framework and adding
>> pm_runtime API.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
>Minor nit: the runtime PM 'put' calls do not need to be the _sync
>versions.  You can easily get by using the "normal" (async) versions
>here.

Will change for next version, was just following what other drivers were
doing.

-- 
balbi
