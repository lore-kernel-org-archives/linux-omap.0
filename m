From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Mon, 11 Aug 2008 02:34:37 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53833 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYHKIei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 04:34:38 -0400
In-Reply-To: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

Hello Jouni,

a couple of questions about these patches....

On Tue, 8 Jul 2008, Jouni Hogander wrote:

> With this patch cpuidle boot problem with cpuidle doesn't exist. Also hang on wake-up seems to
> disappear (haven't seen this far).
> 
> Main points in this patch are:
> 1. Add wkdep between neon and mpu
> 2. Add wkdep between per and core

Could you explain a little further why PER would have a wakeup dependency 
on CORE?  Is this something that we should only enable under certain 
conditions, e.g., latency requirements for a device in PER?  

> 3. Deny hwsup mode before writing next pwrst state

I missed this part of the patch - could you point me at that section?


regards,

- Paul
