From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Thu, 12 Apr 2012 18:35:08 +0530
Message-ID: <4F86D304.1020902@ti.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com> <4F8565C7.4080506@ti.com> <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:59852 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756590Ab2DLNFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 09:05:18 -0400
Received: by obbef5 with SMTP id ef5so2773817obb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 06:05:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Paul,

On Thursday 12 April 2012 12:29 AM, Paul Walmsley wrote:
> That approach sounds fine to me, but I don't think Fernando's patch will
> help with I2C..  Since it uses a custom reset function omap_i2c_reset(),
> the delay will actually need to go there.

While working on fixing this I stumbled upon a couple of other
things which don't seem right.

The i2c custom reset funtion (omap_i2c_reset) uses a hwmod exposed
api to set the SOFTRESET bit, however it then accesses the hwmod
internal structure to poll on RESETDONE status bit. Should there be
another function exposed to poll on RESETDONE too?

_reset() function documents its return value to be -ETIMEDOUT, if the
module fails to reset in time, and hence expects the custom reset
function to return the same in such cases. The omap_i2c_reset() function
seems to return 0 even in cases of timeout. However looking more closely
the return value from _reset() does not seem to be used in the framework
today.

The comment in _ocp_softreset() suggests the intent was to add a new
state to the hwmod state machine.

         /*
          * XXX add _HWMOD_STATE_WEDGED for modules that don't come back 
from
          * _wait_target_ready() or _reset()
          */

is it still the case, or should _reset() just return a void?

regards,
Rajendra


