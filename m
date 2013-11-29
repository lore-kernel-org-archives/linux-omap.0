From: Andreas Naumann <dev@andin.de>
Subject: Re: [PATCH V2] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Fri, 29 Nov 2013 09:34:54 +0100
Message-ID: <529851AE.7090300@andin.de>
References: <EE4E4767751A8B40949306E403F4DDD80322D479@sv03ultra002.ultratronik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dd5612.kasserver.com ([85.13.130.143]:35161 "EHLO
	dd5612.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab3K2IfM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 03:35:12 -0500
In-Reply-To: <EE4E4767751A8B40949306E403F4DDD80322D479@sv03ultra002.ultratronik.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: notasas@gmail.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org

> Nice find, I think I'm also affected by this. However this crashes on
> OMAP3530 pandora because you now access INTERFSEL before interface
> clock is enabled.. This is not a problem on DM37xx because it uses
> different interconnects. You should probably use "context_valid"
> variable in omap2430_glue or similar to decide to write to register or
> not.
>
> Grazvydas

You mean introducing a "context_value"? I'm not sure if i want to add 
more code.
Do you think simple removing the first read is an option? So far we read 
back 0 anyway because the first write to INTERFSEL in resume() set it to 
uninitialized / 0 anyway.



> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
