From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/4] twl-regulator DT adaptation and updates to add new
 regulators
Date: Thu, 01 Mar 2012 11:10:40 +0530
Message-ID: <4F4F0BD8.7090506@ti.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com> <20120229231818.GA8295@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56774 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754025Ab2CAFks (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 00:40:48 -0500
Received: by mail-yw0-f42.google.com with SMTP id q11so77291yhf.15
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 21:40:47 -0800 (PST)
In-Reply-To: <20120229231818.GA8295@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org

On Thursday 01 March 2012 04:48 AM, Mark Brown wrote:
> On Tue, Feb 28, 2012 at 03:09:09PM +0530, Rajendra Nayak wrote:
>> Hi Mark,
>>
>> Here is a consolidated series which adds DT support for twl regulator
>> driver and adds support for VDD1/2/3 regulator and support for
>> fixed LDO V1V8 and V2V1. The patches are based on -next and tested
>> on omap3 beagle and omap4 panda boards.
>
> Applied all, thanks.  Please do try to use subject lines consistent with
> the subsystem.

Thanks Mark, will remember to keep the subject lines consistent
hence forth.
