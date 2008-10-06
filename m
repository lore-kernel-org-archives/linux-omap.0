From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] omap: mmc: fix compile breakage on board-n800-mmc.c
Date: Mon, 6 Oct 2008 13:32:27 +0300
Message-ID: <20081006133227.8fd5e001.jarkko.nikula@nokia.com>
References: <1223284162-7511-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52220 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbYJFKcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 06:32:54 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m96AWaiZ015934
	for <linux-omap@vger.kernel.org>; Mon, 6 Oct 2008 13:32:51 +0300
In-Reply-To: <1223284162-7511-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon,  6 Oct 2008 12:09:22 +0300
"ext Felipe Balbi" <felipe.balbi@nokia.com> wrote:

> Commit 81d2c7d87a9c1eb724788fce7312922effa1b1ae broke
> compilation of board-n800-mmc.c, this patch fixes it.
> 
> Still n810 doesn't boot anymore with current linux-omap.
> Will look into that soon.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800-mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
Heh, I did the very same patch already last week :-)

http://marc.info/?l=linux-omap&m=122286380121424&w=2

I'm not sure but I think N810 was booting then. Or I was using N800.


Jarkko
