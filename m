From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Thu, 19 Aug 2010 22:34:30 +0400
Message-ID: <4C6D7936.3090201@ru.mvista.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>	<20100813080200.18750.37791.stgit@baageli.muru.com>	<4C651635.8000201@ru.mvista.com> <20100813102933.GN12706@atomide.com>	<4C65238D.9080105@ru.mvista.com> <87sk2ao4fr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60458 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab0HSSfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 14:35:21 -0400
Received: by ewy23 with SMTP id 23so1533708ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 11:35:20 -0700 (PDT)
In-Reply-To: <87sk2ao4fr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

Hello.

Kevin Hilman wrote:

>>>>> From: Kevin Hilman <khilman@ti.com>
>>>>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>>>>> mistakenly removed the check for PER when disabling the IO chain.
>>>>> During idle, if the PER powerdomain transitions and CORE does not (as

>>>>   Does not what?

>>> How about ".. and CORE does not transition"?

>>    Transition to what then? Sentense till won't parse right...

>>> Kevin, care to clarify that?
>>    Yeah, looks like a considerable partt of that sentense got omitted...

> No.  Nothing was omitted.  

> It's like saying "Tony drinks Fernet and Kevin does not."  Adding an
> additional "drinks Fernet" at the end is redundant.

    Sorry, the sentence still doesn't parse for me. You don't say "Fernet" 
there BTW, so it's not clear where the PER powerdomain transitions to. What 
goes after the closing parenthesis doesn't clear things up either, it just 
describes what happens if...

> Kevin

WBR, Sergei
