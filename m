From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/06] OMAP3430 Errata, defect fixes and optimizations
Date: Thu, 04 Jun 2009 16:37:50 -0700
Message-ID: <87hbyvd0z5.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03057E76B6@dbde02.ent.ti.com>
	<87oct3d1ai.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:44608 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZFDXhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 19:37:51 -0400
Received: by wf-out-1314.google.com with SMTP id 26so521621wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 16:37:52 -0700 (PDT)
In-Reply-To: <87oct3d1ai.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 04 Jun 2009 16\:31\:01 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> "Nayak, Rajendra" <rnayak@ti.com> writes:
>
>> This series contains a set of patches which implement new 3430 errata, and some optimizations
>> and fixes in the SR driver and DVFS path.
>>
>> These apply on the latest 'pm' branch and are validated on a 3430SDP platform.
>
> Thanks, applying all but the scratchpad locking patch to PM branch.
> See comment/question on that patch.

Oh, and also not applying the PER/WKUP wkdep patch since we already
have a workaround in the GPIO code.

Kevin
