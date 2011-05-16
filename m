From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH] ARM: omap4: i2c reset regs postidle
Date: Mon, 16 May 2011 10:13:16 +0200
Message-ID: <4DD0DC9C.5020300@linaro.org>
References: <1303386420-12997-1-git-send-email-j.weitzel@phytec.de>	 <4DB01F5B.5080607@linaro.org> <1305532568.11112.4.camel@lws-weitzel>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab1EPINf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 04:13:35 -0400
Received: by wya21 with SMTP id 21so3209446wya.19
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 01:13:34 -0700 (PDT)
In-Reply-To: <1305532568.11112.4.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J.Weitzel@phytec.de
Cc: linux-omap@vger.kernel.org, patches@linaro.org, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org

On 05/16/2011 09:56 AM, Somebody in the thread at some point said:
> Am Donnerstag, den 21.04.2011, 13:13 +0100 schrieb Andy Green:
>> On 04/21/2011 12:47 PM, Somebody in the thread at some point said:
>>> Without OMAP_I2C_FLAG_RESET_REGS_POSTIDLE I got i2c controller
>>> timeouts on each accsess after an NACK message.
>>> Taking this flag fix it.
>>
>> Ahhh that will explain why if you accidentally configure LM75 system
>> monitor support, which isn't there on Panda, the I2C controllers die
>> slowly on boot.  Good catch!
>
> Can I get an Acked-by ?

Sure, I had it on my tree for a while too.

Tested-by: Andy Green <andy.green@linaro.org>
Acked-by: Andy Green <andy.green@linaro.org>

-Andy

