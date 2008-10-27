From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [RFC] i2c-omap: Don't wait needlessly
Date: Mon, 27 Oct 2008 18:20:38 +0200
Message-ID: <4905EA56.5050309@nokia.com>
References: <12246059481717-git-send-email-sakari.ailus@nokia.com> <20081024131740.64641d26.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43884 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYJ0QUn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2008 12:20:43 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9RGKeEE032251
	for <linux-omap@vger.kernel.org>; Mon, 27 Oct 2008 18:20:40 +0200
In-Reply-To: <20081024131740.64641d26.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

Jarkko Nikula wrote:
> I would rather, if there is no need for such a long delay like
> OMAP_I2C_TIMEOUT, remove that time_after and msleep(1) stuff and
> just loop few iterations with udelay(1). Zero thinked & tested diff
> attached.

I just though of allowing the reset to take longer as I have no idea how 
long it could take, let alone other versions of OMAP.

> I would say that ndelay(1) just doesn't look relevant to < 1 GHz
> cpus :-)

Good point. On ARM ndelay(1) seems to be equal to udelay(1) at the moment.

I actually just removed the ndelay(1) and again, "delay" won't get past 
1 if I print it after the loop.

It'd be nice to know how it works on other OMAP versions before making 
such changes. :-)

-- 
Sakari Ailus
sakari.ailus@nokia.com
