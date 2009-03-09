From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Mon, 09 Mar 2009 11:25:42 -0700
Message-ID: <87tz62y2mx.fsf@deeprootsystems.com>
References: <1236532839-3696-1-git-send-email-juha.yrjola@solidboot.com>
	<20090309172140.GF7329@atomide.com>
	<8763iizitg.fsf@deeprootsystems.com> <49B55B09.7070803@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:33430 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZCISZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 14:25:49 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1029875wah.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 11:25:46 -0700 (PDT)
In-Reply-To: <49B55B09.7070803@solidboot.com> (Juha Yrjola's message of "Mon\, 09 Mar 2009 20\:08\:09 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Juha Yrjola <juha.yrjola@solidboot.com> writes:

> Kevin Hilman wrote:
>
>> Maybe just a brief description of this scratchpad location is reserved.
>> Is there a boot ROM doc that could be referenced?
>
> I don't know how public the boot ROM behaviour is. On my OMAP34xx TRM,
> the relevant info is in Chapter 26.4.4.4, Software Booting
> Configuration.

I think we can reference the TRM section without describing it and
that should be safe under the NDAs.

Kevin
