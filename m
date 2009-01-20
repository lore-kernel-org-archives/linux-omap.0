From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Is anybody else having problems with SDHC cards on Beagleboard?
Date: Tue, 20 Jan 2009 18:29:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301C69A03EB@dbde02.ent.ti.com>
References: <1232455118.6982.14.camel@surfer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885AbZATNAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 08:00:08 -0500
In-Reply-To: <1232455118.6982.14.camel@surfer>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Hagood <david.hagood@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of David Hagood
> Sent: Tuesday, January 20, 2009 6:09 PM
> To: linux-omap@vger.kernel.org
> Subject: Is anybody else having problems with SDHC cards on 
> Beagleboard?
> 
> I have been trying to bring up a Beagleboard as a development 
> platform for a project at work, but I am having a killer 
> problem: any significant access of the memory card (a class 8 
> SDHC 8G card) will die with a transfer error, followed by 
> about 10 failed sector accesses, followed by the system dying.
> 
> I've tried 2 different Beagleboards and 3 different cards by 
> 2 different manufacturers, and the problem is repeatable on 
> all permutations. I've put the cards into a card reader on my 
> workstation and done a "dd if=/dev/sdf of=/dev/null" to 
> verify the cards aren't wedged.
> 
> I've searched for this on Google and found no references, but 
> I cannot believe I'm the only person seeing this - but am I?
> 
[sp] I am using a Sandisk 4Gb card. Haven't seen any problems.
But, kernel is few weeks old.

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 