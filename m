From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: How to properly enable omap-pm functionality
Date: Tue, 21 Jul 2009 09:41:00 -0700
Message-ID: <87zlayng4j.fsf@deeprootsystems.com>
References: <77796027857787598662944565875381470841-Webmail@me.com>
	<155819222869086342187954491342507868765-Webmail@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:46583 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623AbZGUQlC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 12:41:02 -0400
Received: by pzk42 with SMTP id 42so576183pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 09:41:02 -0700 (PDT)
In-Reply-To: <155819222869086342187954491342507868765-Webmail@me.com> (Elvis Dowson's message of "Tue\, 21 Jul 2009 01\:39\:00 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

>  Hi Kevin,
>                  
> On Monday, 20 July, 2009, at 08:30AM, "Kevin Hilman" <khilman@deeprootsystems.com> wrote:
>
>>You still will not see omap-pm.h included because I did not
>>test DVFS on Overo since just going idle eventually leads
>>to memory corruption.
>>
>>As I stated[1], SDRC settings need some validation on Overo
>>before DVFS can be tested.
>
>>[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg13980.html
>
> The overo is closely based on the beagleboard, so if DVFS is working
> on Beagleboard, wouldn't applying the same changes to the overo
> work?

Probably.  Feel free to try it and submit patches.

Thanks,

Kevin


