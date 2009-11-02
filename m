From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
Date: Mon, 2 Nov 2009 11:49:10 -0600
Message-ID: <4AEF1B96.6070406@ti.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com> <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com> <4ADE5EE4.2030901@ti.com> <71a0d6ff0911020512k478a3f1du929f2abed42be07a@mail.gmail.com> <4AEEE901.6010000@ti.com> <20091102170123.GC15200@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbZKBRtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 12:49:07 -0500
In-Reply-To: <20091102170123.GC15200@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-om>

Alexander Shishkin had written, on 11/02/2009 11:01 AM, the following:
[..]
>>>> Issues with the strategy of restricting to the current 8 bits:
>>>> a) Why extrabits now:
>>>> we have 8 bits now and we would have used all 8 bits with 3630 with the
>>>> mentioned patch. What do we do with the next revision of 3430? Do we want to
>>>> increase the size once it comes along? OR Do we want to do it right now? Why
>>>> wait till we get additional silicons to go figure how to add those bits as
>>>> Richard pointed out, when there could be one more in the pipeline?
>>> But this code will have to be revisited for each additional silicon
>>> revision anyway, right? Why reserve now?
>>>
>> Agreed, that is one of the possible approaches we could take (and
>> seems to be the common consensus), we can review the structure at a
>> later point of time.
>>
>> http://patchwork.kernel.org/patch/54847/ seems to be the right
>> direction for now at least.
> 
> Ok, so let's have it in, perhaps.
Tony, Kevin, upto you guys now..

-- 
Regards,
Nishanth Menon
