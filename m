From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] I2C: Call request_irq with IRQF_DISABLED
Date: Thu, 5 Mar 2009 21:03:35 +0100
Message-ID: <20090305210335.4515f882@hyperion.delvare>
References: <1236261264-16053-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
	<20090305193505.GA32746@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:16803 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbZCEUDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 15:03:54 -0500
In-Reply-To: <20090305193505.GA32746@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On Thu, 5 Mar 2009 21:35:06 +0200, Felipe Balbi wrote:
> That and this one should be going via linux-i2c mainling list. Could you
> send Eero's patch and yours to Jean Delvare (i2c maintainer) ? Please
> keep linux-omap in the loop.

Come on, folks, how many times will I have to repeat myself and what
MAINTAINERS says? Patches to i2c-omap and every other i2c driver for
embedded platforms go to Ben Dooks (Cc'd), not me.

-- 
Jean Delvare
