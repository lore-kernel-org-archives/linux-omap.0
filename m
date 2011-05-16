From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: [PATCH] ARM: omap4: i2c reset regs postidle
Date: Mon, 16 May 2011 09:56:08 +0200
Message-ID: <1305532568.11112.4.camel@lws-weitzel>
References: <1303386420-12997-1-git-send-email-j.weitzel@phytec.de>
	 <4DB01F5B.5080607@linaro.org>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.tricorecenter.de ([217.6.246.34]:54619 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab1EPH4K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 03:56:10 -0400
In-Reply-To: <4DB01F5B.5080607@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andy.green@linaro.org
Cc: linux-omap@vger.kernel.org, patches@linaro.org, andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org

Am Donnerstag, den 21.04.2011, 13:13 +0100 schrieb Andy Green:
> On 04/21/2011 12:47 PM, Somebody in the thread at some point said:
> > Without OMAP_I2C_FLAG_RESET_REGS_POSTIDLE I got i2c controller
> > timeouts on each accsess after an NACK message.
> > Taking this flag fix it.
> 
> Ahhh that will explain why if you accidentally configure LM75 system 
> monitor support, which isn't there on Panda, the I2C controllers die 
> slowly on boot.  Good catch!

Can I get an Acked-by ?

Jan


