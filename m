From: Romit Dasgupta <romit@ti.com>
Subject: Re: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 14:09:33 +0530
Message-ID: <4B0F9045.6030404@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59990 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbZK0Ijc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 03:39:32 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAR8da2q028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 02:39:38 -0600
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote:
> Hi,
> 
> I am finding the response of touchscreen on the omap3evm very slow.
> 
> Here is my test:
> On console, I run : watch -n2 "cat /proc/interrupts"
> Then, I tap the touchscreen approximately once per second. However,
> (usually) no interrupts are registered. As I increase the frequency
> of 'taps' more and more interrupts are registered. But still not
> matching exact taps.
> 
> However, when I keep the cpu busy with "cat /dev/zero > /dev/null &"
> each tap is recognized.
> 
Do you see this even if we don't enable OFF?
