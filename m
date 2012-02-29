From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 2/2] OMAPDSS: APPLY: make ovl_enable/disable synchronous
Date: Wed, 29 Feb 2012 10:48:52 +0000
Message-ID: <4F4E0294.6000406@gmx.de>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>	 <1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>	 <4F4DFA30.2040503@gmx.de> <1330511438.1934.95.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:53781 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757699Ab2B2KtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 05:49:11 -0500
In-Reply-To: <1330511438.1934.95.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>

Hi Tomi,

On 02/29/2012 10:30 AM, Tomi Valkeinen wrote:
> On Wed, 2012-02-29 at 10:13 +0000, Florian Tobias Schandinat wrote:
>> On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
>>> ovl->enable/disable are meant to be synchronous so that they can handle
>>> the configuration of fifo sizes. The current kernel doesn't configure
>>> fifo sizes yet, and so the code doesn't need to block to function (from
>>> omapdss driver's perspective).
>>>
>>> However, for the users of omapdss a non-blocking ovl->disable is
>>> confusing, because they don't know when the memory area is not used
>>> any more.
>>>
>>> Furthermore, when the fifo size configuration is added in the next merge
>>> window, the change from non-blocking to blocking could cause side
>>> effects to the users of omapdss. So by making the functions block
>>> already will keep them behaving in the same manner.
>>
>> Is there any difference to doing it now?
>> I agree that this should be fixed but if we can't avoid breaking users I'd
>> prefer to break them in a merge window not in late rc stage. Or did we introduce
>> these functions just in the last merge window?
> 
> Yes, these were introduced in the merge window. And I explicitly said
> the functions are blocking so that they can perform their job. And just
> to clarify, the functions already use a mutex, so in that sense they are
> blocking. They just don't currently wait until the HW has finished with
> the overlay.

okay, than I'll apply this patch as is. I was just worried about asking Linus to
pull something that is labled as "Breaks existing users" now, but that doesn't
look like an issue here.


Best regards,

Florian Tobias Schandinat

> 
> The problem was raised by Rob Clark, who's writing the omapdrm driver,
> as he doesn't have a way to ensure that the overlay has been truly
> disabled and the memory is is no longer in use.
> 
> (I forgot to cc him for the patch, adding him now).
> 
>  Tomi
> 

