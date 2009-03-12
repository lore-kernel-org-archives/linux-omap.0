From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP:clock: missing list_del for clk_notifier_unregister
Date: Thu, 12 Mar 2009 07:22:13 -0700
Message-ID: <87mybqakiy.fsf@deeprootsystems.com>
References: <1236790153-9324-1-git-send-email-nm@ti.com>
	<alpine.DEB.2.00.0903120128570.26959@utopia.booyaka.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DBC4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:35603 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbZCLOWT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 10:22:19 -0400
Received: by an-out-0708.google.com with SMTP id c2so360593anc.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 07:22:16 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51DBC4@dlee02.ent.ti.com> (Nishanth Menon's message of "Thu\, 12 Mar 2009 02\:33\:19 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Palande Ameya <ameya.palande@nokia.com>

"Menon, Nishanth" <nm@ti.com> writes:

>> -----Original Message-----
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Thursday, March 12, 2009 9:31 AM
>> To: Menon, Nishanth
>> Cc: linux-omap@vger.kernel.org; Woodruff, Richard; Nayak, Rajendra; Gupta,
>> Ramesh; Palande Ameya
>> Subject: Re: [PATCH] OMAP:clock: missing list_del for
>> clk_notifier_unregister
>  
>> Just to clarify, this is currently against the PM branch.  There's a new
>
> Yes. This is against the PM branch
>

OK, I'll add this to PM branch...

>> version of the clock notifier patch coming out soon against l-o; will roll
>> this fix in.


And then pull in the new version when it appears.

Kevin
