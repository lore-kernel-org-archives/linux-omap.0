From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 27 Nov 2013 14:32:46 +0100
Message-ID: <5295F47E.7030409@gmail.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com> <52938A12.5030100@ti.com> <5295F211.1050605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:52449 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab3K0Ncu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 08:32:50 -0500
Received: by mail-bk0-f51.google.com with SMTP id 6so3166139bkj.24
        for <linux-omap@vger.kernel.org>; Wed, 27 Nov 2013 05:32:49 -0800 (PST)
In-Reply-To: <5295F211.1050605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, joelf@ti.com
Cc: linux-omap@vger.kernel.org, gururaja.hebbar@ti.com, balajitk@ti.com, nm@ti.com, s.neumann@raumfeld.com, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

On 11/27/2013 02:22 PM, Sekhar Nori wrote:
> + Kevin
> 
> On Monday 25 November 2013 11:04 PM, Joel Fernandes wrote:
>> On 11/17/2013 04:19 PM, Daniel Mack wrote:
>>> This patch makes the edma driver resume correctly after suspend. Tested
>>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>>
>>> All information can be reconstructed by already known runtime
>>> information.
>>>
>>> As we now use some functions that were previously only used from __init
>>> context, annotations had to be dropped.
>>>
>>> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Tested-by: Joel Fernandes <joelf@ti.com>
>>> Acked-by: Joel Fernandes <joelf@ti.com>
>>
>> Hi Sekhar,
>>
>> Can you consider pulling this patch? It has been tested and Acked. Thanks.
> 
> Kevin had some inputs on previous version of this patch. Were you able
> to make sure he is okay with this version being merged?

I had concerns about the feedback I got, and haven't got answers yet.

In particular, I'm not convinced that using runtime PM to suspend
channels would actually save any power during runtime, or have any other
benefit. But I might be wrong - maybe someone at TI could comment on that?


Thanks,
Daniel

