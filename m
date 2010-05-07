From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 3/5] gic: Add set_type callback
Date: Fri, 7 May 2010 12:56:49 +0200
Message-ID: <h2z63386a3d1005070356r23cee2c7m5d0ac534ec0182d4@mail.gmail.com>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	 <1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36575 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab0EGK4w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 06:56:52 -0400
In-Reply-To: <1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: adharmap@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>, Catalin Marinas <catalin.marinas@arm.com>, Yinghai Lu <yinghai@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Linus Walleij <linus.walleij@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, Philby John <pjohn@in.mvista.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@unipv.it>, Andrea Gallo <andrea.gallo@stericsson.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Abhijeet Dharmapurikar <adharmap@quicinc.com>, Rabin VINCENT <rabin.vincent@stericsson.com>, Mian.Yousaf.Kaukab@stericsson.com

2010/1/27  <adharmap@codeaurora.org>:

> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
>
> Add gic_set_type callback to set an irq as level or edge triggered type

Abhijeet, will you pursue this patchset?

Else we will pick it up and propose our solution for the U8500 needs which
are similar.

Yours,
Linus Walleij
