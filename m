From: Kyle Manna <kyle.manna@fuel7.com>
Subject: Re: [PATCH RFC] mfd: twl4030-madc: Enable ADC channels 3-6
Date: Fri, 09 Dec 2011 00:38:01 -0600
Message-ID: <4EE1ACC9.5000404@fuel7.com>
References: <CAGDS+n=QJNjCyfQ2zvPweC=aBDWt=n+y1ccgTAafqJCYt991yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.fuel7.com ([74.222.0.51]:54502 "EHLO mail.fuel7.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab1LIGiG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 01:38:06 -0500
In-Reply-To: <CAGDS+n=QJNjCyfQ2zvPweC=aBDWt=n+y1ccgTAafqJCYt991yg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>

On 12/08/2011 05:13 PM, Steve Sakoman wrote:
> Currently the driver does not explicitly set the TWL4030_USB_SEL_MADC_MCPC
> bit to enable madc input channels 3 through 6.  This results in readings near
> zero for these channels since the inputs are grounded if this bit is not set.

I've run into this same problem and have fixed it the same way, looks 
good to me.

Reviewed-by: Kyle Manna <kyle@kylemanna.com>

- Kyle
