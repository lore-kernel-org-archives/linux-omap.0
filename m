From: Andrew Chew <AChew@nvidia.com>
Subject: RE: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 12 Mar 2013 15:21:16 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA5179F@HQMAIL03.nvidia.com>
References: <1363053266-515-1-git-send-email-achew@nvidia.com>
 <513EF43F.4030107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8714 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab3CLWVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 18:21:22 -0400
In-Reply-To: <513EF43F.4030107@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> On 03/12/2013 02:54 AM, Andrew Chew wrote:
> > The pwm-backlight driver now takes a mandatory regulator that is
> > gotten during driver probe.  Initialize a dummy regulator to satisfy
> > this requirement.
> 
> Can you point me to the commit which makes a regulator mandatory for
> pwm-backlight?
> Why the regulator is mandatory?
> The 4430SDP (or Blaze) and Zoom2 is just happy alone with the PWM why
> should we have dummy regulators?

I'm resubmitting the patch as a patch series that includes the pwm-backlight
change.  See the cover letter for an explanation of why this is needed.
