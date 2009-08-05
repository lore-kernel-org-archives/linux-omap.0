From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH] OMAP: GPIO: Avoid generating extra IRQs
Date: Wed, 5 Aug 2009 19:56:37 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760047F6AECFF@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1246602393-8812-1-git-send-email-ext-eero.nurkkala@nokia.com>,<20090805131703.GG7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42371 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZHER4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 13:56:51 -0400
In-Reply-To: <20090805131703.GG7374@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org


>> It is possible for GPIO IRQ lines configured with
>> falling edge triggering only to get IRQs at the
>> rising edge upon the exit of offmode. And vice
>> versa. Prevent such IRQs to arrive by generating
>> the IRQ obeying the detection scheme.
>
> Is the situation still the same if we temporarily change the
> level lines to edge for the duration of idle? This would allow
> waking up even if the line is level.

I admit that I haven't tested such a schenario. But I guess
it's not different than what it used to be ... Is there a sample
to try out?

However, if there's no edge detection (nor and or level detection)
set at all, it will still generate soft IRQs, which possibly needs
some rethinking (maybe WARN if no egde nor level detection on
the GPIO IRQ). But it's been that way, so I figured no need to
change that.


> Also, have you checked the code flow on omap1 when l, gen, gen0 & gen1
> are not initialized? Just wondering ;)
> 
> Tony

Right, possibly a compile warning.

- Eero