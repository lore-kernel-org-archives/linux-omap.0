From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RESEND PATCH v3 05/11] ASoC: davinci-mcasp: Interrupts property
 to optional and add interrupt-names
Date: Tue, 8 Oct 2013 13:38:29 +0300
Message-ID: <5253E0A5.8090909@ti.com>
References: <cover.1379590035.git.jsarha@ti.com> <0140013bd747832968ccd7dce8f9270e1459d018.1379590036.git.jsarha@ti.com> <20131007215657.GC2976@kartoffel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43823 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106Ab3JHKil (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 06:38:41 -0400
In-Reply-To: <20131007215657.GC2976@kartoffel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>

On 10/08/2013 12:56 AM, Mark Rutland wrote:
> On Thu, Sep 26, 2013 at 08:18:30PM +0100, Jyri Sarha wrote:
>> +- interrupts : Interrupt numbers for McASP, currently not used by the driver
>> >+- interrupt-names : Known interrupt names are "tx" and "rx"
> Are these_all_  the interrupts the McASP may generate? I was under the
> impression there were also separate interrupts for errors.

Those were all I could find from AM335X TRM.

Cheers,
Jyri
