From: Andrew Chew <AChew@nvidia.com>
Subject: RE: [PATCH 1/2 v2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Wed, 13 Mar 2013 13:38:31 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA519E4@HQMAIL03.nvidia.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-2-git-send-email-achew@nvidia.com> <51403DFC.90609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:2536 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab3CMUik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 16:38:40 -0400
In-Reply-To: <51403DFC.90609@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > +/* Dummy regulator for pwm-backlight driver */ static struct
> > +regulator_consumer_supply backlight_supply =
> > +	REGULATOR_SUPPLY("enable", NULL);
> 
> 'enable' is just too generic, the device name should be also provided:
> 	REGULATOR_SUPPLY("enable", "pwm-backlight");

You're right.  I don't like how generic it is as well.  But I don't think
"pwm-backlight" works...at least, not for me when I test it.  What
does work is "backlight.x" where x is some number (for me, it's 1).
Problem is, I don't know what it would be for you.  If only there
was a way to wildcard that...

Would it be better if we called the regulator something other than
"enable"?  Maybe "backlight-enable", or "bl-enable" for brevity?
