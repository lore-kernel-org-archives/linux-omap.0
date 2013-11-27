From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 27 Nov 2013 18:52:25 +0530
Message-ID: <5295F211.1050605@ti.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com> <52938A12.5030100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43787 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab3K0NYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 08:24:17 -0500
In-Reply-To: <52938A12.5030100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: joelf@ti.com, Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org, gururaja.hebbar@ti.com, balajitk@ti.com, nm@ti.com, s.neumann@raumfeld.com, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

+ Kevin

On Monday 25 November 2013 11:04 PM, Joel Fernandes wrote:
> On 11/17/2013 04:19 PM, Daniel Mack wrote:
>> This patch makes the edma driver resume correctly after suspend. Tested
>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>
>> All information can be reconstructed by already known runtime
>> information.
>>
>> As we now use some functions that were previously only used from __init
>> context, annotations had to be dropped.
>>
>> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Tested-by: Joel Fernandes <joelf@ti.com>
>> Acked-by: Joel Fernandes <joelf@ti.com>
> 
> Hi Sekhar,
> 
> Can you consider pulling this patch? It has been tested and Acked. Thanks.

Kevin had some inputs on previous version of this patch. Were you able
to make sure he is okay with this version being merged?

I have some comments for which I will send another e-mail.

Thanks,
Sekhar
