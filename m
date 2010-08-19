From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Thu, 19 Aug 2010 11:14:32 -0700
Message-ID: <87sk2ao4fr.fsf@deeprootsystems.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080200.18750.37791.stgit@baageli.muru.com>
	<4C651635.8000201@ru.mvista.com> <20100813102933.GN12706@atomide.com>
	<4C65238D.9080105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38203 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab0HSSOg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 14:14:36 -0400
Received: by pzk26 with SMTP id 26so868140pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 11:14:36 -0700 (PDT)
In-Reply-To: <4C65238D.9080105@ru.mvista.com> (Sergei Shtylyov's message of
	"Fri, 13 Aug 2010 14:50:53 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> Hello.
>
> Tony Lindgren wrote:
>
>>>> From: Kevin Hilman <khilman@ti.com>
>>>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>>>> mistakenly removed the check for PER when disabling the IO chain.
>
>>>> During idle, if the PER powerdomain transitions and CORE does not (as
>
>>>   Does not what?
>
>> How about ".. and CORE does not transition"?
>
>    Transition to what then? Sentense till won't parse right...
>
>> Kevin, care to clarify that?
>
>    Yeah, looks like a considerable partt of that sentense got omitted...
>

No.  Nothing was omitted.  

It's like saying "Tony drinks Fernet and Kevin does not."  Adding an
additional "drinks Fernet" at the end is redundant.

Kevin

