From: <Tero.Kristo@nokia.com>
Subject: RE: 34xx off-mode support fixes
Date: Fri, 4 Jul 2008 11:57:35 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394303C38A7@vaebe110.NOE.Nokia.com>
References: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com> <87zloynshc.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24644 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbYGDI6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 04:58:39 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m648w0JE031558
	for <linux-omap@vger.kernel.org>; Fri, 4 Jul 2008 03:58:37 -0500
Content-class: urn:content-classes:message
In-Reply-To: <87zloynshc.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jouni.hogander@nokia.com
Cc: linux-omap@vger.kernel.org

 
>Do you have any guesses what is wrong in Rajendras cpuidle 
>code? Is it that dma save/restore? At least I couldn't figure 
>it out from your patches.

Not sure, one possible cause is that cpuidle code is calling pwrdm_set_next_pwrst(), I recall having some issues if I tried calling this function within idle loop. Rest of the PM code is calling set_pwrdm_state().

I haven't really tried cpuidle too much, I just wanted to get suspend + dynamic idle work as the code in those is simpler => easier to get chip off state to work.

-Tero
