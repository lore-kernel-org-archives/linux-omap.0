From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Subject: Re: [PATCH 2/2] omap: rx51: initialize platform data for twl4030
 powerbutton
Date: Mon, 14 Mar 2011 13:14:28 +0200
Message-ID: <20110314111428.GA10465@smart.research.nokia.com>
References: <078f4a01fa523a0f9e0033c52f52413d60cc5431.1299860654.git.ext-denis.2.karpov@nokia.com>
 <0aaadf1ebe1864fa310a8b1330dd688079983f8d.1299860654.git.ext-denis.2.karpov@nokia.com>
 <alpine.DEB.1.10.1103141253370.23033@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:53550 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab1CNLOo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 07:14:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1103141253370.23033@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

> >From: Denis Karpov <ext-denis.2.karpov@nokia.com>
> >+static struct twl4030_pwrbutton_data rx51_pwrbutton_data = {
> >+	.rep		= 1,
> >+};
> >+
> 
> Doesn't this enable them? If you want to keep the default behaviour,
> you can just omit the platform data.

Yes, you are right, thanks. I meant to set it to 0 after testing, but 
then it is not needed indeed. 

So patch 2/2 is not needed and patch 1/2 does not belong here - I'll 
resend it to input/mfd lists/maintainers.

Denis
