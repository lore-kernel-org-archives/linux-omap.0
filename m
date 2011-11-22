From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH 00/26] PM: Create the AVS class of drivers
Date: Tue, 22 Nov 2011 18:40:07 +0100
Message-ID: <4ECBDE77.6000703@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com> <20111122164302.GI6624@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34535 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1KVRkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 12:40:25 -0500
In-Reply-To: <20111122164302.GI6624@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: jean.pihet@newoldbits.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

Hi Mark,

On 11/22/2011 5:43 PM, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 04:05:44PM +0100, jean.pihet@newoldbits.com wrote:
>
>> AVS is a power management technique which controls the operating
>> voltage of a device in order to optimize (i.e. reduce) its power
>> consumption. The voltage is adapted depending on static factors
>> (chip manufacturing process) and dynamic factors (temperature
>> depending performance).
>> AVS is also called SmartReflex on OMAP devices.
>
> This sounds a lot like what devfreq (which was recently merged) is
> supposed to do.  Have you looked at the overlap there?

devfreq is a fmwk for DVFS governors at device level, whereas AVS stands 
for Adaptive Voltage Scaling. This technique does not involve any 
frequency change, and does a fine voltage adjustment to adapt to silicon 
process / aging / thermal variation based on a HW closed loop.

Both DVFS and AVS can be used independently.

I think that AVS does belong to the voltage control infrastructure more 
than the DVFS/freq one.

But that just my .2 cents

Regards,
Benoit


