From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 12:50:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com> <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com> <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <20121025101212.GD21217@arwen.pp.htv.fi> <20121026201539.GD29548@arwen.pp.htv.fi> <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com> <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com> <20121030123254.GD29095@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48097 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab2J3Mux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 08:50:53 -0400
In-Reply-To: <20121030123254.GD29095@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Tue, 30 Oct 2012, Felipe Balbi wrote:

> the wmb() patch should help, but you said it doesn't, right ?

Correct.  Not sure why you think that would help; the problem is almost 
certainly PM-idle related, given that the problem goes away by reverting 
Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: convert 
I2C driver to PM QoS for MPU latency constraints".

The problem is consistent and easy to reproduce here.

> without seeing debugging information on the failing case, it'll be very
> difficult to sort this one out provided noone else seems to be able to
> reproduce it.

Aaro sees it also, so it's definitely not a local artifact.

It's not very surprising that the problem doesn't appear with the extra 
logging enabled, since the extra logging presumably keeps the system out 
of idle.  

Anyway, you are welcome to the userspace, bootloader, and X-loader here if 
you would like to try to reproduce it.  They've been sent to Jean and 
Kevin and Shubhrajyoti already.  Simply request it and I will send links.


- Paul
