From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Fix possible un-initialized waitqueue in
 McBSP
Date: Mon, 22 Sep 2008 16:30:10 +0300
Message-ID: <20080922163010.034ca5fb.jarkko.nikula@nokia.com>
References: <1221831398-10700-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41256 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIVNaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 09:30:55 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8MDUP6M028908
	for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2008 16:30:53 +0300
Received: from kikka3 (esdhcp040183.research.nokia.com [172.21.40.183])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with SMTP id m8MDUOZb012679
	for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2008 16:30:24 +0300
In-Reply-To: <1221831398-10700-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Fri, 19 Sep 2008 16:36:38 +0300
Jarkko Nikula <jarkko.nikula@nokia.com> wrote:

> TX or RX irq waitqueues are un-initialized if interrupt would occur
> immediately after requesting it. I don't know is it HW failure, but one
> Beagle board is showing spurious TX interrupt from McBSP2 (and only from it)
> just after requesting it.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
Dismiss this. I'll send a better version fixing this and the actual reason why this TX interrupt is occurring immediately from Beagle McBSP2 (bootloader let it running).


Jarkko
