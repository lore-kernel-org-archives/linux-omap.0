From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V3 0/2] Add mandatory regulator for all users of pwm-backlight.
Date: Thu, 14 Mar 2013 09:44:51 +0100
Message-ID: <51418E03.6020103@ti.com>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46499 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab3CNIo4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 04:44:56 -0400
In-Reply-To: <1363214006-10662-1-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, linux-omap@vger.kernel.org

On 03/13/2013 11:33 PM, Andrew Chew wrote:
> Many backlights are enabled via GPIO.  We can generalize the GPIO to a
> fixed regulator.
> 
> The enable regulator needs to be mandatory because there was no good way
> to determine the difference between opting out of the regulator, and probe
> deferral.
> 
> This series of patches is intended to add a dummy regulator (or a GPIO
> regulator) for all users of the pwm-backlight.
> 
> The last patch in the series will always be the pwm-backlight change to add
> this mandatory regulator.  Patches following up to that patch add the
> mandatory regulator on a per mach family basis.  Once all users of
> pwm-backlight have been patched, this series can be applied in order to
> maintain bisectability.

I'm not really happy with the mandatory regulator since for example the
SDP4430 should not need one... Other than that the backlight works after the
series.

To both patch:

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

