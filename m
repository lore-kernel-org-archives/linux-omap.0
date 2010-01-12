From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP] [PATCH] cleaner ceil function for uv to vsel conversion
Date: Tue, 12 Jan 2010 14:28:35 +0530
Message-ID: <4B4C39BB.5090409@ti.com>
References: <1263189218.16324.3.camel@boson> <876378mg2a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54652 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266Ab0ALI6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jan 2010 03:58:44 -0500
In-Reply-To: <876378mg2a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman wrote:
> Romit Dasgupta <romit@ti.com> writes:
> 
>> Cleaner ceil function.
> 
> Needs better subject and better changelog.
> 
> Subject should probably be something like: OMAP: 
> 
>   [PATCH] OPP: TWL/TPS: optimize uv to vsel function
> 
> And changelog should describe the motiviation for the patch or a
> description of the problem you're trying to solve.
The description of the problem is "Cleaner ceil function for uv to vsel
conversion".

I think this patch is simple enough for people on this list to understand the
optimization. I am sorry I cant be more descriptive.

> IOW, is this a
> correctness fix, or an optimization, etc.  Looks to me like it's tring
> to compensate for some rounding issues, but please describe in detail
> in the changelog.
