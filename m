From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
Date: Sat, 11 Apr 2015 00:23:55 +0200
Message-ID: <20150410222355.GE20669@piout.net>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
 <20150324155916.cfd1b7ab442271466160283f@linux-foundation.org>
 <55234F25.5060708@ti.com>
 <5523820C.2010709@compulab.co.il>
 <5527894E.9000807@ti.com>
 <20150410133730.8f84b2894efcf1bde075048f@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46205 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751560AbbDJWX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2015 18:23:59 -0400
Content-Disposition: inline
In-Reply-To: <20150410133730.8f84b2894efcf1bde075048f@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: Keerthy <a0393675@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 10/04/2015 at 13:37:30 -0700, Andrew Morton wrote :
> Is there any way in which we can get all systems working properly?  If
> there's no way of auto-detecting an external oscillator then perhaps a
> module parameter is needed.  If so, it would be better if the driver
> were to default to internal oscillator (ie: current behaviour), and the
> module parameter selects the external oscillator.  This way, existing
> systems are unaffected by the kernel upgrade.
> 

Actually, I would use the common clock framework, allowing to chose
between the internal and an external clock source by using the "clocks"
property. This would also allow to have the correct reference count on
that 32k internal clock. It may not matter now but for example, not
doing so became a problem on at91.

As a fallback, if no clocks property is available, I would use the
internal 32k to keep DT ABI backward compatibility.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
