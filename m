From: Felipe Balbi <balbi@ti.com>
Subject: Re: Dropping omap3430 ES1.0 support in mainline
Date: Mon, 4 Oct 2010 10:03:40 +0300
Message-ID: <20101004070340.GF2559@legolas.emea.dhcp.ti.com>
References: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
 <20101001215832.GC3117@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44029 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab0JDHDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:03:41 -0400
Content-Disposition: inline
In-Reply-To: <20101001215832.GC3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 01, 2010 at 04:58:32PM -0500, Tony Lindgren wrote:
>* Anand Gadiyar <gadiyar@ti.com> [101001 14:38]:
>> Tony, all,
>>
>> The OMAP3430 ES1.0 was pretty much a test chip, with the only known board
>> being the 3430ES1.0 SDP. There are only a small number of these boards
>> outside TI and within TI, they've likely never been used in over 2 years.
>> It's unlikely that these boards still work on mainline, and likely have
>> been broken in linux-omap since the very beginning.
>>
>> Between ES1.0 and ES2.0 we've had several major changes in the clock
>> nodes,
>> and IPs. However we're still keeping code/data on these in the kernel
>> today.
>>
>> Since all later OMAP3 chips have been very similar to ES2.0, it probably
>> makes sense to drop support for the ES1.0. This would result in a small
>> but probably significant reduction in the current code. If you're okay
>> with dropping this support, we can slowly start working on this.
>>
>> What do you think?
>
>No thanks!

yeah, I don't like the idea of simply dropping support either and would
be very happy if I had an old h2 board to fix up the omap_udc.c code
which is horrible :-p

-- 
balbi
