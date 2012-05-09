From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v4 0/9] OMAPDSS: APPLY: Treat overlay manager timings
 as shadow registers
Date: Wed, 9 May 2012 16:54:26 +0530
Message-ID: <4FAA53EA.7040400@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>  <1336558256-26140-1-git-send-email-archit@ti.com> <1336561991.3962.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42371 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757145Ab2EILZI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 07:25:08 -0400
In-Reply-To: <1336561991.3962.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 09 May 2012 04:43 PM, Tomi Valkeinen wrote:
> On Wed, 2012-05-09 at 15:40 +0530, Archit Taneja wrote:
>> An overlay manager's timings (the manager size, and blanking parameters if an
>> LCD manager) are DISPC shadow registers, and they should hence follow the
>> correct programming model.
>>
>> This set makes the timings an extra_info parameter in manager's private data .
>> The interface drivers now apply the timings in instead of directly writing to
>> registers.
>>
>> This change also prevents the need to use display resolution for overlay
>> checks, hence making some of the APPLY functions less dependent on the display.
>> Some DISPC functions that needed display width can also use these privately
>> stored timings.
>>
>> Changes since v3:
>>
>> - Remove direct setting of go bit in dpi_set_timings()
>> - Take some of the patches in "OMAPDSS: Misc fixes and cleanups" and make them a
>>    part of this series as they are more related.
>> - Don't have an initial set of manager timings in private data, only check
>>    manager and overlay parameters once the manager is enabled.
>>
>> These patches apply over:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git dev
>>
>> Reference tree containing this series:
>>
>> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_timing_and_fixes_2
>>
>> Tested on OMAP4 SDP and Panda.
>
> I did some quick tests on omap3 overo, worked fine. I'll merge to dss
> master branch.

Russ did some tests on more omap3 boards, the tree which he used has 
some slight changes comapred to what I have posted, but it's more or 
less the same.

Could you add 'Tested-by: Russ.Dill@ti.com' if not too difficult, I 
missed out doing that.

Thanks,
Archit


>
>   Tomi
>

