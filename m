From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH] ARM: omap4: i2c reset regs postidle
Date: Thu, 21 Apr 2011 13:13:15 +0100
Message-ID: <4DB01F5B.5080607@linaro.org>
References: <1303386420-12997-1-git-send-email-j.weitzel@phytec.de>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39573 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab1DUMNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 08:13:20 -0400
Received: by wwa36 with SMTP id 36so2022197wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 05:13:19 -0700 (PDT)
In-Reply-To: <1303386420-12997-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org

On 04/21/2011 12:47 PM, Somebody in the thread at some point said:
> Without OMAP_I2C_FLAG_RESET_REGS_POSTIDLE I got i2c controller
> timeouts on each accsess after an NACK message.
> Taking this flag fix it.

Ahhh that will explain why if you accidentally configure LM75 system 
monitor support, which isn't there on Panda, the I2C controllers die 
slowly on boot.  Good catch!

-Andy
