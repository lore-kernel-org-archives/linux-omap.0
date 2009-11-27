From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 14:11:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
 <4B0F9045.6030404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54156 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZK0Ild convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 03:41:33 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAR8faVM015090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 02:41:39 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAR8faBt028302
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 14:11:36 +0530 (IST)
In-Reply-To: <4B0F9045.6030404@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Dasgupta, Romit 
> Sent: Friday, November 27, 2009 2:10 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: omap3evm: touchscreen delays on pm branch
> 
> Premi, Sanjeev wrote:
> > Hi,
> > 
> > I am finding the response of touchscreen on the omap3evm very slow.
> > 
> > Here is my test:
> > On console, I run : watch -n2 "cat /proc/interrupts"
> > Then, I tap the touchscreen approximately once per second. However,
> > (usually) no interrupts are registered. As I increase the frequency
> > of 'taps' more and more interrupts are registered. But still not
> > matching exact taps.
> > 
> > However, when I keep the cpu busy with "cat /dev/zero > /dev/null &"
> > each tap is recognized.
> > 
> Do you see this even if we don't enable OFF?
> 
Yes. Sleep_while_idle=0; enable_off_mode=0
~sanjeev