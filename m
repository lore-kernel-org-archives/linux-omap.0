From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Fri, 13 Aug 2010 14:50:53 +0400
Message-ID: <4C65238D.9080105@ru.mvista.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com> <20100813080200.18750.37791.stgit@baageli.muru.com> <4C651635.8000201@ru.mvista.com> <20100813102933.GN12706@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34325 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761478Ab0HMKwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 06:52:30 -0400
Received: by ewy23 with SMTP id 23so1131705ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 03:52:29 -0700 (PDT)
In-Reply-To: <20100813102933.GN12706@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

Hello.

Tony Lindgren wrote:

>>> From: Kevin Hilman <khilman@ti.com>
>>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>>> mistakenly removed the check for PER when disabling the IO chain.

>>> During idle, if the PER powerdomain transitions and CORE does not (as

>>   Does not what?

> How about ".. and CORE does not transition"?

    Transition to what then? Sentense till won't parse right...

> Kevin, care to clarify that?

    Yeah, looks like a considerable partt of that sentense got omitted...

> Tony

WBR, Sergei
