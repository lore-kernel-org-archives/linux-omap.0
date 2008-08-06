From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH 0/2] Add PM early init
Date: Wed, 06 Aug 2008 11:40:12 +0300
Message-ID: <1218012012.29799.15.camel@kj-ubuntu>
References: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34534 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbYHFIhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 04:37:40 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m768bJU8014803
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 03:37:38 -0500
In-Reply-To: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Here is an update for Peter's patch-set implementing the early voltage
controller initialization. Applies over l-o master branch.

Boot tested on sdp board.

Br,
Kalle

On to, 2008-07-31 at 16:37 +0300, ext Peter 'p2' De Schrijver wrote:
> This patchset add an early init function to initialize the voltage controller
> and the off mode polarity before the drivers depending on these features are 
> enabled.
> 
> Peter 'p2' De Schrijver (2):
>   Move voltage controller configuration to pm34xx.c
>   Add early init for voltage controller configuration and off mode
>     polarity.
> 
>  arch/arm/mach-omap2/pm34xx.c      |   71 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex.c |   60 -------------------------------
>  2 files changed, 71 insertions(+), 60 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
