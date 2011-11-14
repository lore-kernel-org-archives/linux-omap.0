From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Tue, 15 Nov 2011 00:39:00 +0400
Message-ID: <4EC17C64.7010409@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-5-git-send-email-yanok@emcraft.com> <20111111001203.GD31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:50247 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab1KNUi7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Nov 2011 15:38:59 -0500
In-Reply-To: <20111111001203.GD31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Tony,

On 11.11.2011 04:12, Tony Lindgren wrote:
> This looks OK but let's concentrate on getting things working with
> board-generic.c and DT only in mainline kernel.
> 
> I can apply this into testing-board, but let's not cause more churn
> in mainline with the board files that will be disappearing.
> 
> Can you please split it into something minimal for mainline that
> allows booting with DT, and then another patch for testing-board
> branch?

Well, it already boots with DT actually. Did you mean booting with DT
and board-generic? I have to admit I don't know how to proceed here:
board-generic initialize twl4030 which we don't have on our board...
Could you give me some pointer how I'm supposed to handle this?

Regards, Ilya.
