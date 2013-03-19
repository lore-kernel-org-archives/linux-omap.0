From: Nishanth Menon <nm@ti.com>
Subject: Re: Beagleboard xM - Bogomips are very low
Date: Tue, 19 Mar 2013 11:09:39 -0500
Message-ID: <20130319160938.GA31417@kahuna>
References: <5148819A.5040500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60977 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899Ab3CSQJl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 12:09:41 -0400
Content-Disposition: inline
In-Reply-To: <5148819A.5040500@free.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guillaume Gardet <guillaume.gardet@free.fr>
Cc: linux-omap@vger.kernel.org

On 16:17-20130319, Guillaume Gardet wrote:
> Hi,
> 
> On a Beagleboard xM rev. B, I noticed that vanilla kernel 3.4.6 have the folowing bogomips for 300MHz and 800 MHz operations: 262.08 and 700.57.
> 
> With kernel 3.7.10, I have : 175.65 and 467.41 bogompis.
> 
> Any idea why bogomips are so low now?
using my DTS cpufreq series (which I am about to post to linux-omap):
https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cpu0-omap-all-v2
and a test script:
http://pastebin.com/zrr8ptge

I See (3.9-rc3):
http://pastebin.com/4JCV3dnX

bogomips@ boot:
BogoMIPS        : 395.67
Boot scaling frequency =600000
TESTING for 1 seconds at 300000
current scaling frequency(for 300000) =300000
bogomips@ frequency 300000:
BogoMIPS        : 197.83
TESTING for 1 seconds at 600000
current scaling frequency(for 600000) =600000
bogomips@ frequency 600000:
BogoMIPS        : 395.67
TESTING for 1 seconds at 800000
current scaling frequency(for 800000) =800000
bogomips@ frequency 800000:
BogoMIPS        : 527.56
-- 
Regards,
Nishanth Menon
