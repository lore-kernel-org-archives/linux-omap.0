From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Tue, 03 Dec 2013 10:24:18 -0800
Message-ID: <878uw1ssh9.fsf@linaro.org>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com>
	<52938A12.5030100@ti.com> <5295F211.1050605@ti.com>
	<5295F47E.7030409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:55842 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab3LCSYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 13:24:22 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so21657850pbb.30
        for <linux-omap@vger.kernel.org>; Tue, 03 Dec 2013 10:24:21 -0800 (PST)
In-Reply-To: <5295F47E.7030409@gmail.com> (Daniel Mack's message of "Wed, 27
	Nov 2013 14:32:46 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, joelf@ti.com, linux-omap@vger.kernel.org, gururaja.hebbar@ti.com, balajitk@ti.com, nm@ti.com, s.neumann@raumfeld.com, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> On 11/27/2013 02:22 PM, Sekhar Nori wrote:
>> + Kevin
>> 
>> On Monday 25 November 2013 11:04 PM, Joel Fernandes wrote:
>>> On 11/17/2013 04:19 PM, Daniel Mack wrote:
>>>> This patch makes the edma driver resume correctly after suspend. Tested
>>>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>>>
>>>> All information can be reconstructed by already known runtime
>>>> information.
>>>>
>>>> As we now use some functions that were previously only used from __init
>>>> context, annotations had to be dropped.
>>>>
>>>> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>> Tested-by: Joel Fernandes <joelf@ti.com>
>>>> Acked-by: Joel Fernandes <joelf@ti.com>
>>>
>>> Hi Sekhar,
>>>
>>> Can you consider pulling this patch? It has been tested and Acked. Thanks.
>> 
>> Kevin had some inputs on previous version of this patch. Were you able
>> to make sure he is okay with this version being merged?
>
> I had concerns about the feedback I got, and haven't got answers yet.
>
> In particular, I'm not convinced that using runtime PM to suspend
> channels would actually save any power during runtime, or have any other
> benefit. 

/me returning from a week off

The amount of power to be saved depends on the activity in the system.
If DMA is unused, at least the clocks could be gated allowing the
possibility of the enclosing power domain to be gated if other devices
are also clock gated, etc. etc.

However, my comments were not really about power saving, they were about
designing things in a way that are scalable and match the longer term
goals of converting drivers to be runtime PM centric.  For example, if
someone did want to add real runtime PM to this driver later, they would
need to rework much of this.  So my suggestion was to do runtime PM the
right way from the beginning.

That being said, I'm not the maintainer of this driver so don't get to
make the final call.  I will just say that from what I've seen here, I
don't think this is the right approach.

Kevin
