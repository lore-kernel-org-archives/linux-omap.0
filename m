From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 14:03:59 -0700
Message-ID: <871v8mizb4.fsf@deeprootsystems.com>
References: <1285079310-15888-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1009211400460.4677@utopia.booyaka.com>
	<878w2uj1tv.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1009211425530.4677@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47457 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0IUVEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 17:04:04 -0400
Received: by pvg2 with SMTP id 2so1565367pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Sep 2010 14:04:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009211425530.4677@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 21 Sep 2010 14:27:09 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 21 Sep 2010, Kevin Hilman wrote:
>
>> FWIW
>> 
>> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> as I'm using this for testing the various hwmod conversions.
>
> Thanks Kevin, added that in.  I know you've been testing some of the other 
> patches here too, so please let me know if you would like Tested-by:'s or 
> Acked-by:'s there.

I guess you can put a Tested-by for me on everything in your
hwmod_2.6.37 branch as I've been staging and testing those for a bit
now.

Also, one other thing I noticed in that branch: the locking patch from
me:

   OMAP: hwmod: separate list locking and hwmod hardware locking

has a stray '[PATCH]' in the shortlog which should probably be removed
as well.

Kevin
