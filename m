From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/6] N900 DTS additions for 3.14
Date: Wed, 29 Jan 2014 09:04:46 -0600
Message-ID: <52E9188E.1080404@ti.com>
References: <1389475023-11616-1-git-send-email-sre@debian.org> <20140120155950.GB17118@earth.universe> <52DE612E.2080205@baylibre.com> <20140121132653.GA8964@earth.universe> <20140129150328.GA25527@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36914 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbaA2PEu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jan 2014 10:04:50 -0500
In-Reply-To: <20140129150328.GA25527@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On 01/29/2014 09:03 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Jan 11, 2014 at 10:16:57PM +0100, Sebastian Reichel wrote:
>> Here are a couple of additions for the Nokia N900 Device Tree
>> Source file. All related drivers changes are queued for 3.14
>> (except for the tpa6130a2, which got merged into 3.13).
>>
>> I may have some more additions if the driver changes for the
>> accelerometer, the touchscreen or the wireless lan chip will be
>> queued up.
> 
> Ping. If I'm not mistaken the merge window will probably be closed
> at the weekend (2014-01-19 + 2 weeks = 2014-02-02).
> 
> P.S.: Accelerometer, Touchscreen and WLAN driver changes haven't
> made it into 3.14, so the patchset I mailed is complete.
> 
> -- Sebastian
> 

It is usually suggested for dts patches to be cced with devicetree and
linux-arm-kernel lists as well..

-- 
Regards,
Nishanth Menon
