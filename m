From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Android on N810 File System Problem
Date: Wed, 30 Apr 2008 05:46:22 -0500
Message-ID: <152c662ddc4540ddad11fe3f9fa81ad0@felipebalbi.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com> <48116F5C.9040009@googlemail.com> <20080425183605.GA27479@kedavra.cpe.vivax.com.br> <87fxt7my4o.fsf@nokia.com> <20080427223248.GA5962@kedavra.cpe.vivax.com.br> <20080428233827.GE8449@atomide.com> <20080429090032.GA25363@bulgaria.corp.google.com> <87bq3ry8o7.fsf@nokia.com> <20080430102036.GA23558@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58311 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586AbYD3Kq3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 06:46:29 -0400
In-Reply-To: <20080430102036.GA23558@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Kalle Valo <kalle.valo@nokia.com>, Tony Lindgren <tony@atomide.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org



On Wed, 30 Apr 2008 03:20:36 -0700, Brian Swetland <swetland@google.com>
wrote:
> [Kalle Valo <kalle.valo@nokia.com>]
>> Brian Swetland <swetland@google.com> writes:
>> >
>> > This was the show-stopper for me.  When I last got things hobbling
>> > along on n8x0, the binary-only wlan module was incompatible with
>> > newer kernels than 2.6.21 (changes in some network data structures).
>>
>> That's exactly the problem. I have written something about it here:
>>
>>
>
https://garage.maemo.org/pipermail/cx3110x-devel/2007-December/000007.html
> 
> Just did a quick diff between v2.6.21 and v2.6.24 and the skbuff changes
> are pretty daunting.  Doesn't look like there's an easy hack here...
> 
>> Currently there's nothing I can do to resolve the issue, unfortunately.
> 
> Pity.  It'd be nice to get newer kernels running on the n8x0 -- it's
> nice hardware.

eheheh, reverse engineering 2.6.21 driver with a jtag sounds fun :-p

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

