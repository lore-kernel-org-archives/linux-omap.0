From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 16:51:15 +0200
Message-ID: <1299768675.2017.230.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari>  <4D78E3F5.2090600@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43049 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab1CJOvT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:51:19 -0500
In-Reply-To: <4D78E3F5.2090600@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 08:45 -0600, Stephan Raue wrote:
> Hi,
> 
> if i try this patch series the boot stops after (seeing via serial console):
> 
>    Starting kernel ...
> 
>    Uncompressing Linux... done, booting the kernel.
> 
> without this patch series i can see the boot to th OS. I am using this 
> patches on top of
> 
>    http://gitorious.org/linux-omap-dss2/linux/commits/master
> 
> Do i anything wrong or do i use a wrong git repo (the patches apply 
> cleanly)? Her my kernel config: http://fpaste.org/9Esw/

Ah, I guess you hit one yet unsolved problem on on omap4: VENC register
access fails. 

Can you try switching this off: CONFIG_OMAP2_DSS_VENC.

I need to make some quick hack to get VENC disabled on OMAP4 until we
find the solution for this.

 Tomi


