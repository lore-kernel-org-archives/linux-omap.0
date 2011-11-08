From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] gpio/omap: minor cleanups for v3.2
Date: Tue, 08 Nov 2011 11:39:42 -0800
Message-ID: <4EB9857E.5060908@ti.com>
References: <8739g91dp5.fsf@ti.com> <4EB1C3CD.4030907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35474 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756309Ab1KHTjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 14:39:53 -0500
Received: by mail-vx0-f177.google.com with SMTP id e1so1107967vcg.22
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 11:39:50 -0800 (PST)
In-Reply-To: <4EB1C3CD.4030907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Grant,

On 11/02/2011 03:27 PM, Kevin Hilman wrote:
> 
>> Please pull the following OMAP GPIO cleanups for v3.2.
>>
>> Just a heads up: we're also working on another large series of cleanup
>> for this driver that we'll be trying to merge for v3.2.
>>
>> Kevin
> 
> I don't see this in linux-next or your gpio/next branch.  Are you
> planning to pull this for v3.2?

...how about v3.2-rc?

Kevin

>> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
>>
>>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
>>
>> are available in the git repository at:
>>   git://gitorious.org/khilman/linux-omap-pm.git for_3.2/gpio-cleanup
>>
>> Kevin Hilman (1):
>>       gpio/omap: replace MOD_REG_BIT macro with static inline
>>
>> Todd Poynor (1):
>>       gpio/omap: check return value from irq_alloc_generic_chip
>>
>>  drivers/gpio/gpio-omap.c |   59 ++++++++++++++++++++++++++-------------------
>>  1 files changed, 34 insertions(+), 25 deletions(-)
> 

