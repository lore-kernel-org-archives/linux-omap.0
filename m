From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
 kxte9  accelerometer
Date: Tue, 10 Nov 2009 19:35:39 +0100
Message-ID: <20091110193539.7e1392f3@hyperion.delvare>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from poutre.nerim.net ([62.4.16.124]:55147 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543AbZKJSfg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 13:35:36 -0500
In-Reply-To: <1257877729-25647-1-git-send-email-chudson@kionix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 10 Nov 2009 13:28:47 -0500, chudson@kionix.com wrote:
> From: Chris Hudson <chudson@kionix.com>
> 
> This is a request for comments for adding driver support for the Kionix KXTE9 
> digital tri-axis accelerometer.  This part features built-in tilt position 
> (orientation), wake-up and back-to-sleep algorithms, which can trigger a 
> user-configurable physical interrupt.  The driver uses i2c for device 
> communication, a misc node for IOCTLs, and input nodes for reporting 
> acceleration data and interrupt status information.
> 
> Signed-off-by: Chris Hudson <chudson@kionix.com>

Nack. We want less accelerometer drivers polluting drivers/hwmon, not
more.

-- 
Jean Delvare
