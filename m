From: Andrew Chew <AChew@nvidia.com>
Subject: RE: [PATCH 1/2 v2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Wed, 13 Mar 2013 14:12:38 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA51A0E@HQMAIL03.nvidia.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-2-git-send-email-achew@nvidia.com> <51403DFC.90609@ti.com>
 <643E69AA4436674C8F39DCC2C05F7638629CA519E4@HQMAIL03.nvidia.com>
 <20130313205914.GB29025@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:5798 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931Ab3CMVMq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 17:12:46 -0400
In-Reply-To: <20130313205914.GB29025@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Thierry Reding [mailto:thierry.reding@avionic-design.de]
> Sent: Wednesday, March 13, 2013 1:59 PM
> To: Andrew Chew
> Cc: Peter Ujfalusi; Alex Courbot; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2 v2] ARM: OMAP: board-4430sdp: Provide regulator
> to pwm-backlight
> 
> * PGP Signed by an unknown key
> 
> On Wed, Mar 13, 2013 at 01:38:31PM -0700, Andrew Chew wrote:
> > > > +/* Dummy regulator for pwm-backlight driver */ static struct
> > > > +regulator_consumer_supply backlight_supply =
> > > > +	REGULATOR_SUPPLY("enable", NULL);
> > >
> > > 'enable' is just too generic, the device name should be also provided:
> > > 	REGULATOR_SUPPLY("enable", "pwm-backlight");
> >
> > You're right.  I don't like how generic it is as well.  But I don't
> > think "pwm-backlight" works...at least, not for me when I test it.
> > What does work is "backlight.x" where x is some number (for me, it's 1).
> > Problem is, I don't know what it would be for you.  If only there was
> > a way to wildcard that...
> >
> > Would it be better if we called the regulator something other than
> > "enable"?  Maybe "backlight-enable", or "bl-enable" for brevity?
> 
> The second parameter needs to match the device name. For the 4430sdp
> board this should be "pwm-backlight" since the name will be generated from
> the .name and .id fields of the struct platform_device. .id = -1 will result in no
> .<id> suffix being attached, so the device should be named "pwm-backlight".
> The first parameter needs to match the name of the supply that the driver
> requests, so "enable" is correct since the call to regulator_get() uses that.

Ah, I see.  That makes sense.  Thanks, Thierry!  "pwm-backlight" it is, then,
and I'll make sure to check for this for the other boards.
