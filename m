From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: compile break on dss2 branch for zoom3
Date: Thu, 11 Mar 2010 15:11:35 +0200
Message-ID: <20100311131135.GU20878@nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB4FA5@dbde02.ent.ti.com>
 <1268307780.28571.101.camel@tubuntu.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59253 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab0CKNMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 08:12:03 -0500
Content-Disposition: inline
In-Reply-To: <1268307780.28571.101.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "ext Y, Kishore" <kishore.y@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 11, 2010 at 12:43:00PM +0100, Valkeinen Tomi (Nokia-D/Helsinki) wrote:
>> When I disable usb, build goes through but the board does not bootup with this image. It is stuck at uncompressing linux.
>
>Yes, mainstream linux tree seems to be broken. Not much I can do to help
>you there. You can try rebasing on top of later mainstrean version,
>perhaps it's been fixed there.

you need to enable CONFIG_PM_RUNTIME

-- 
balbi
