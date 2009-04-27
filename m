From: Ashwin Bihari <abihari@gmail.com>
Subject: OMAP35x GP TIMER as a wakeup trigger
Date: Mon, 27 Apr 2009 11:49:32 -0400
Message-ID: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:7112 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbZD0Ptd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 11:49:33 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1407350yxj.1
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 08:49:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Greetings,

I need to implement a timer as a wake up trigger while my custom board
is in the suspended state. I read in the TRM that all of the GPTIMERs
have the capability of generating a wake up interrupt. I'm using the
2.6.28-rc8 PM Kernel which contains the patch to enable all the
GPTIMERS as wake up sources.

Could someone familiar with this scheme quickly elaborate all the
steps that I need to go through to get the system to come out of
suspend purely on the timer? Is it is just enough to setup the timer
correctly, enable the interrupt in the appropriate register and assume
that the PM layer will get the interrupt and do the right thing, or is
there more that I have to do?

Also, as as additional thing, if the PM layer handles the interrupt
and begins the wake-up process, if I could know where that
specifically happens, that'd be great since I need to know that the
wake-up process is being triggered by the GPTIMER as opposed to the
other wakeup triggers and deal with that differently.

Regards
-- Ashwin
