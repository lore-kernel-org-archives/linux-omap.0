From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Fri, 4 Jul 2008 14:39:53 +0300
Message-ID: <20080704113953.GB4397@codecarver.research.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com> <20080702131127.GA4404@codecarver.research.nokia.com> <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com> <20080702154253.GC4404@codecarver.research.nokia.com> <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com> <87prpum7nr.fsf@trdhcp146196.ntc.nokia.com> <873amqknae.fsf@trdhcp146196.ntc.nokia.com> <20080704110556.GA4397@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42603 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbYGDLlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 07:41:07 -0400
Content-Disposition: inline
In-Reply-To: <20080704110556.GA4397@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: ext Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

> 
> I tried the same uImage here on my SDP. It goes to off nicely after
> bootup, but after using the console, VDD2 does not to off anymore. VDD1
> does go to off.

I reverted the u-boot patch to allow IOPAD wakeup on UART and now it
works.

Cheers,

Peter.
-- 
goa is a state of mind
