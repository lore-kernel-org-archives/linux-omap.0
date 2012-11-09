From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
Date: Fri, 9 Nov 2012 10:29:43 -0600
Message-ID: <509D2F77.6090702@ti.com>
References: <1352477961-7634-1-git-send-email-jon-hunter@ti.com> <20121109162259.GO6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38401 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab2KIQ3s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Nov 2012 11:29:48 -0500
In-Reply-To: <20121109162259.GO6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/09/2012 10:22 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121109 08:21]:
>> If the header soc.h is included more than once in a source (for example
>> once directly by the source file and once indirectly by another header
>> file), then the compiler will generate redefintion errors for the macros
>> in soc.h. Prevent this by only allowing the content in soc.h to be
>> included once.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>
>> Please note that I ran into this problem when rebasing my dmtimer fixes
>> series [1] on Tony's Linux-OMAP master branch. I am including plat/cpu.h
>> in dmtimer.h and I found several other files including dmtimer.h are also
>> including soc.h and so generate a lot of errors.
>>
>> [1] http://marc.info/?l=linux-omap&m=135231490218361&w=2
> 
> As these headers are private to mach-omap2, I'd rather not allow including
> them more than once so we can eventually clean up the includes further.
> 
> We should include the headers directly where used, except for the
> legacy board-*.c files that will be going away anyways.
> 
> Including the files directly should fix this easily, if not let me
> know.

The alternative fix is to ensure anyone including dmtimer.h also
includes soc.h. However, I did not know if we should have such a
dependency. If you are ok with that then that is what I will do for now.
It is not a massive change.

Cheers
Jon
