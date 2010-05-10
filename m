From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 10 May 2010 10:03:12 +0200
Message-ID: <73F3CED4-60D5-4351-A921-335110542B6F@dominion.thruhere.net>
References: <1273474110-22451-1-git-send-email-svadivu@ti.com> <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl> <FCCFB4CDC6E5564B9182F639FC356087030428879D@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:34981 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab0EJIDR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 04:03:17 -0400
Received: by ewy20 with SMTP id 20so813553ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 01:03:15 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030428879D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>


Op 10 mei 2010, om 10:01 heeft Guruswamy, Senthilvadivu het volgende geschreven:

> Building a multi-omap kernel is not impacted as long as the display is not choosen in the build.  Usually display is chosen from the board file.

So you are saying it *IS* broken when wanting vrfb on omap3 and tiler on omap4, right?



> 
>> -----Original Message-----
>> From: Koen Kooi [mailto:koen@dominion.thruhere.net] 
>> Sent: Monday, May 10, 2010 1:10 PM
>> To: Guruswamy, Senthilvadivu
>> Cc: linux-omap@vger.kernel.org; 
>> linux-fbdev-devel@lists.sourceforge.net; tony@atomide.com; 
>> tomi.valkeinen@nokia.com; Hiremath, Vaibhav
>> Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
>> 
>> 
>> Op 10 mei 2010, om 08:48 heeft Senthilvadivu Guruswamy het 
>> volgende geschreven:
>> 
>>> Exclude VRFB from OMAP4 onwards and include only for
>>> OMAP2 and OMAP3 builds.  In OMAP4 VRFB HW IP is replaced
>>> with a new HW IP "TILER"
>>> 
>>> --- a/drivers/video/omap2/Kconfig
>>> +++ b/drivers/video/omap2/Kconfig
>>> @@ -3,6 +3,10 @@ config OMAP2_VRAM
>>> 
>>> config OMAP2_VRFB
>>> 	bool
>>> +	depends on FB_OMAP2 && (!ARCH_OMAP4)
>>> +	default y if (ARCH_OMAP2 || ARCH_OMAP3)
>>> +	help
>>> +	  OMAP VRFB buffer support is efficient for rotation
>> 
>> How does this work for multi-omap kernels, e.g. building a 
>> kernel with beagle and panda support?
>> 
>> regards,
>> 
>> Koen

