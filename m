From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] twl4030 power support for 3430SDP
Date: Thu, 01 Oct 2009 16:19:57 -0700
Message-ID: <878wfubt2a.fsf@deeprootsystems.com>
References: <1254423262-25380-1-git-send-email-khilman@deeprootsystems.com>
	<20091001192431.GW32041@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:42382 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbZJAXTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:19:55 -0400
Received: by pxi9 with SMTP id 9so672383pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:19:59 -0700 (PDT)
In-Reply-To: <20091001192431.GW32041@smtp.gmail.com> (Amit Kucheria's message of "Thu\, 1 Oct 2009 22\:24\:31 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Amit Kucheria <amit.kucheria@canonical.com> writes:

> On 09 Oct 01, Kevin Hilman wrote:
>> I've been carrying these in the PM branch, but now that twl4030 power
>> support is in mainline, these can be queued for 2.6.33.
>> 
>> Kevin Hilman (1):
>>   OMAP3: PM: 3430SDP: add initial twl4030 power scripts
>> 
>> Rajendra Nayak (1):
>>   OMAP3: PM: 3430SDP: Update twl4030 power scripts and device groups
>> 
>>  arch/arm/mach-omap2/board-3430sdp.c |   93 ++++++++++++++++++++++++++++++++++-
>>  1 files changed, 91 insertions(+), 2 deletions(-)
>> 
>
> Hi Kevin,
>
> Do you want to wait until I push patches that modify the way the scripts are
> loaded in memory? (they now allow overlapping scripts to work around space
> constraints)
>
> Also we now have very simplified scripts that use broadcast messages. These
> might still need to be tweaked for the various boards though. It works on the
> RX51.

Well, I don't *want* to wait because that means I would have to rework
these patches.  :)  

But it sounds waiting is the right thing.  How close are you to having
the new scripting stuff ready?  Should we put it into the PM branch in
the meantime so it can get some testing on other boards than RX51?

Kevin

