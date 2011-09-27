From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 4/9] regulator: twl: Make twl-regulator driver extract
 data from DT
Date: Tue, 27 Sep 2011 20:18:27 +0530
Message-ID: <4E81E23B.8040706@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-5-git-send-email-rnayak@ti.com> <20110927121415.GC4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53256 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913Ab1I0Osg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:48:36 -0400
Received: by mail-pz0-f41.google.com with SMTP id 5so18520120pzk.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:48:35 -0700 (PDT)
In-Reply-To: <20110927121415.GC4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tuesday 27 September 2011 05:44 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:47PM +0530, Rajendra Nayak wrote:
>
>> +#ifdef CONFIG_OF
>> +	char			compatible[128];
>> +#endif
>
> Might it not be better to just make this a pointer to const char?

Yes, my bad.
