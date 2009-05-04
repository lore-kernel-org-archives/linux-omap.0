From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] onenand_init: Allow disabling sync read and write based
 on	flags (Re: [PATCH 1/4] onenand init: Rename board-n800-flash.c to	gpmc-onenand.c)
Date: Mon, 04 May 2009 11:27:57 +0300
Message-ID: <49FEA70D.8070704@nokia.com>
References: <40106.192.168.10.89.1241073191.squirrel@dbdmail.itg.ti.com> <20090430140336.GC12986@atomide.com> <20090430185307.GF12986@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18035 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZEDI1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 04:27:14 -0400
In-Reply-To: <20090430185307.GF12986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: vimal singh <vimalsingh@ti.com>, "dedekind@infradead.org" <dedekind@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atommide.com>

Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [090430 07:06]:
>> * vimal singh <vimalsingh@ti.com> [090429 23:33]:
>>> 'gpmc-onenand.c' is still confusing name. This is not going to used in
>>> all boards anyway.
>> Why do you think this cannot be used for all boards?
>>
>> The GPMC timings are totally based on the onenand chip features.
> 
> And these two patches make omap3430sdp to work with the gpmc-onenand
> code. Sync mode does not work, but it seems like it was never enabled
> for sdp anyways.
> 
> Similar patch should work for other boards too.
> 
> Tony
> 

This is not quite right.  OneNAND only allows 3 possibilities:

1. Async: call 'omap2_onenand_set_async_mode()'

2. Sync Read: call 'omap2_onenand_set_sync_mode()' but force 'sync_write' variable to be always zero

3. Sync Read and Sync Write: call 'omap2_onenand_set_sync_mode()' as now
