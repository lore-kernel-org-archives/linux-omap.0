From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: Where is DSP Gateway
Date: Thu, 20 Aug 2009 15:24:04 +0300
Message-ID: <4A8D4064.7050005@nokia.com>
References: <deb0f030908181654m71a6a10l10a29426377a702a@mail.gmail.com> <deb0f030908182145r68b8021cj49f2fac24d330eca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29291 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbZHTMYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 08:24:39 -0400
In-Reply-To: <deb0f030908182145r68b8021cj49f2fac24d330eca@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Suresh Rajashekara <suresh@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Suresh Rajashekara wrote:
> Hi All,
> 
> We had been using dspgateway 3.3 on 2.6.16. Recently we changed our
> kernel to 2.6.29 and we found that the dspgateway driver has been
> removed from the tree
> ( http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=2512fd29db4eb09e82d182596304c7aaf76d2c5c).
> 
> What do I do, If I want to use the dspgateway on 2.6.29?
> 
> I tried searching the patch for dspgateway on 2.6.29, but found none
> except this
> http://archive.netbsd.se/?ml=linux-kernel&a=2009-07&m=11155350
> 
> Any pointers would be really helpful
> 
> Thanks in advance,
> Suresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I think DSP-gateway is not maintained, and they are now using bridgedriver.

Cheers,
Ameya.
