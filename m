From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: enable EHCI by default
Date: Fri, 6 Dec 2013 11:51:48 +0200
Message-ID: <52A19E34.7090302@ti.com>
References: <1386205695-26191-1-git-send-email-thomas@cozybit.com> <20131205171104.GZ26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53943 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757141Ab3LFJwD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Dec 2013 04:52:03 -0500
In-Reply-To: <20131205171104.GZ26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thomas Pedersen <thomas@cozybit.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk

On 12/05/2013 07:11 PM, Tony Lindgren wrote:
> * Thomas Pedersen <thomas@cozybit.com> [131204 17:09]:
>> This is needed for the pandaboard (ES) kernel to detect
>> the ethernet device during boot. Useful for NFS root etc.
> 
> Thanks for the patch, just to clarify why we have not been able
> to apply this is EHCI blocks deeper PM states for at least omap3
> currently. And this means the PM related tests won't run properly
> out of the box..
> 
> Roger has been working to get EHCI working properly with PM,
> and the recent interrupts-extended binding and the addition of
> wake-up interrupts to pinctrl-single.c should allow us to do that
> soon. Maybe Roger can summarize what else might still be missing?
> 

Right, I just need to spend some time on it.

cheers,
-roger
