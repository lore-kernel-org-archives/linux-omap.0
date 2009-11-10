From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
 kxte9 accelerometer
Date: Tue, 10 Nov 2009 22:39:07 +0100
Message-ID: <20091110223907.1f47b07f@hyperion.delvare>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
	<20091110193539.7e1392f3@hyperion.delvare>
	<4AF9B5E3.1060902@kionix.com>
	<4AF9B847.3070008@cam.ac.uk>
	<4AF9CDF2.2070003@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from poutre.nerim.net ([62.4.16.124]:62286 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758238AbZKJVjF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 16:39:05 -0500
In-Reply-To: <4AF9CDF2.2070003@kionix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 10 Nov 2009 15:32:50 -0500, Chris Hudson wrote:
> Thank you for your insight Jonathan.  The driver was originally written 
> for the 2.6.29 omap-android kernel to facilitate integration of the 
> kxte9 into customer projects.  Unfortunately, it seems that things in 
> the kernel have changed since then, but I'm not sure how much we can 
> change without sacrificing compatibility with the Android sensor API.  
> Is there a different place where this driver could go without requiring 
> significant redesign?

I don't think a move implies a redesign. You could put exactly the same
driver under drivers/misc, drivers/accel, drivers/input or what do I
know. I don't want it in drivers/hwmon, but I don't care about anything
else.

-- 
Jean Delvare
