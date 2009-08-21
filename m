From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Patch format for submission?
Date: Fri, 21 Aug 2009 15:10:54 +0200
Message-ID: <87skflmhwh.fsf@deeprootsystems.com>
References: <1250695463.10817.4.camel@blitz>
	<alpine.DEB.2.00.0908190921130.5294@utopia.booyaka.com>
	<4A8C28E6.7060209@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:33392 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbZHUNK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 09:10:59 -0400
Received: by gxk1 with SMTP id 1so913328gxk.17
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 06:11:00 -0700 (PDT)
In-Reply-To: <4A8C28E6.7060209@am.sony.com> (Tim Bird's message of "Wed\, 19 Aug 2009 09\:31\:34 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Bird <tim.bird@am.sony.com>
Cc: Paul Walmsley <paul@pwsan.com>, Peter Barada <peterb@logicpd.com>, linux-omap <linux-omap@vger.kernel.org>

Tim Bird <tim.bird@am.sony.com> writes:

> Paul Walmsley wrote:
>> Hi Peter,
>> 
>> On Wed, 19 Aug 2009, Peter Barada wrote:
>> 
>>> 1) Does anyone have a URL of the format patches should be in that are
>>> submitted to the linux-omap list?
>>>
>>> I've got some patches to add base support for the Logic OMAP 35x SOM and
>>> Torpedo boards and I'd like to submit them in the right format for
>>> inclusion and push into mainline.
>> 
>> Documentation/SubmittingPatches and Documentation/CodingStyle are pretty 
>> good intros to this.
>>
> Also, Andrew Morton wrote a paper called "The Perfect Patch"
> with a nice checklist of attributes.
>
> http://userweb.kernel.org/~akpm/stuff/tpp.txt
>

In addition to above suggestions, I highly recommend using git tools
which automate many of these recommended steps.

Usin 'git format-patch' and then 'git send-email' will get you a long
ways.

Kevin
