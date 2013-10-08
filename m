From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RESEND PATCH v3 04/11] ASoC: davinci-mcasp: Extract DMA channels
 directly from DT
Date: Tue, 8 Oct 2013 10:05:03 +0300
Message-ID: <5253AE9F.3000500@ti.com>
References: <cover.1379590035.git.jsarha@ti.com> <dc7012e1c2ae59c35eedd9328139f1060048b395.1379590036.git.jsarha@ti.com> <20131007215323.GB2976@kartoffel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39901 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab3JHHFS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 03:05:18 -0400
In-Reply-To: <20131007215323.GB2976@kartoffel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>

On 10/08/2013 12:53 AM, Mark Rutland wrote:
> On Thu, Sep 26, 2013 at 08:18:29PM +0100, Jyri Sarha wrote:
>> >Extract DMA channels directly from DT as they can not be found from
>> >platform resources anymore. This is a work-around until davinci audio
>> >driver is updated to use dmaengine.
> How long will this conversion take?
>

That is uncertain, definitely not in time for v3.13.

Best regards,
Jyri
