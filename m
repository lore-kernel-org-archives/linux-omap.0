From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [RFC] i2c-omap: Don't wait needlessly
Date: Tue, 25 Nov 2008 11:35:32 +0200
Message-ID: <492BC6E4.7030104@nokia.com>
References: <12246059481717-git-send-email-sakari.ailus@nokia.com> <20081024131740.64641d26.jarkko.nikula@nokia.com> <4905EA56.5050309@nokia.com> <20081121214353.GA4927@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46443 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYKYJix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:38:53 -0500
In-Reply-To: <20081121214353.GA4927@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

ext Tony Lindgren wrote:
> * Sakari Ailus <sakari.ailus@nokia.com> [081027 09:22]:
>> Jarkko Nikula wrote:
>>> I would rather, if there is no need for such a long delay like
>>> OMAP_I2C_TIMEOUT, remove that time_after and msleep(1) stuff and
>>> just loop few iterations with udelay(1). Zero thinked & tested diff
>>> attached.
>> I just though of allowing the reset to take longer as I have no idea how  
>> long it could take, let alone other versions of OMAP.
>>
>>> I would say that ndelay(1) just doesn't look relevant to < 1 GHz
>>> cpus :-)
>> Good point. On ARM ndelay(1) seems to be equal to udelay(1) at the moment.
>>
>> I actually just removed the ndelay(1) and again, "delay" won't get past  
>> 1 if I print it after the loop.
>>
>> It'd be nice to know how it works on other OMAP versions before making  
>> such changes. :-)
> 
> Let me know if you come up with a refreshed patch for this, ignoring
> for now.

I think the need for this patch has largely gone away as i2c-omap 
appears not to do msleep() anymore for every second transfer or so.

-- 
Sakari Ailus
sakari.ailus@nokia.com

