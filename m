From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13] OMAP: omap_device: add flag to disable automatic bus-level suspend/resume
Date: Thu, 24 Jun 2010 11:28:22 -0700
Message-ID: <8739wcb7zt.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-11-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232136440.1550@utopia.booyaka.com>
	<87zkykfhyp.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006241205460.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54683 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0FXS2Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 14:28:25 -0400
Received: by pxi8 with SMTP id 8so328872pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 11:28:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006241205460.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 24 Jun 2010 12:06:00 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 24 Jun 2010, Kevin Hilman wrote:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>> 
>> > Hi Kevin,
>> >
>> > A few comments:
>> >
>> > Your "add runtime PM support at bus-level" series has a unstated 
>> > dependency on this patch.  If you fix one minor issue (below), it's 
>> > probably easiest if you merge it with that other series to avoid 
>> > cross-dependencies.
>> 
>> If I switch (back) to just using pm_runtime_* API in the system PM
>> path _noirq methods, then rather than setting this flag at the
>> omap_device level, drivers that want to prevent this can simply
>> do a runtime_pm_get_sync() if they want to prevent a bus-level
>> suspend.
>> 
>> Any thoughts/objectsion to that?
>
> Sounds fine to me.

OK, good.  Then I'll just drop this patch.

Thanks,

Kevin
