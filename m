From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices
 for ASoC drivers
Date: Fri, 23 Nov 2012 14:14:25 -0600
Message-ID: <50AFD921.1020205@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-3-git-send-email-ricardo.neri@ti.com> <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com> <50AA2D01.5020302@ti.com> <20121120011526.GF4483@opensource.wolfsonmicro.com> <50AD6FB0.3050808@ti.com> <20121122010358.GB4371@opensource.wolfsonmicro.com> <50AED989.40408@ti.com> <20121123021211.GL4385@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39345 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab2KWUPa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Nov 2012 15:15:30 -0500
In-Reply-To: <20121123021211.GL4385@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, tony@atomide.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org



On 11/22/2012 08:12 PM, Mark Brown wrote:
> On Thu, Nov 22, 2012 at 08:03:53PM -0600, Ricardo Neri wrote:
>> On 11/21/2012 07:03 PM, Mark Brown wrote:
>
>>> instantiation infrastructure in there which is rather Linux specific.
>
>> But the board files are only for Linux, right? The ASoC drivers will
>> always be initialized anyways. They will reach probe only if the
>> devices are present.
>
> Could you be more specific please?
>

Sorry, I meant that the drivers will try to register anyways. The will 
only probe if there is a matching device for them.
