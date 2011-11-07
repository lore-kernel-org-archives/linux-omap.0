From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 1/4] regulator: helper routine to extract regulator_init_data
Date: Mon, 07 Nov 2011 11:57:27 +0530
Message-ID: <4EB77A4F.5010007@ti.com>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>	<20111104202905.GA3918@quad.lixom.net>	<20111104211447.GC2541@opensource.wolfsonmicro.com>	<20111104212216.GA5756@quad.lixom.net>	<20111104212910.GB8266@opensource.wolfsonmicro.com>	<CAOesGMgA7UayF9SJUP0YLnj86GmKBrajsBxv4_kRNNqCsvKTYg@mail.gmail.com>	<20111104214650.GC8266@opensource.wolfsonmicro.com> <CAOesGMjkcExKXhNN1nFGey=wBie0PQGp2XS_r-5Rr3X0p4eNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:56315 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932224Ab1KGG1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 01:27:35 -0500
In-Reply-To: <CAOesGMjkcExKXhNN1nFGey=wBie0PQGp2XS_r-5Rr3X0p4eNhg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Saturday 05 November 2011 03:46 AM, Olof Johansson wrote:
>>> Yeah, ok, but it shouldn't be part of the description of regulator
>>> >>  properties per se. See how gpio does it, defining how a gpio-specifier
>>> >>  is crafted. The equivalent should be done for regulators.
>> >
>> >  That seems to be pretty much exactly what's being done here, and like
>> >  the GPIO bindings it's specified in the core document.  Though perhaps
>> >  there's some aspect of how the document is written that's missing.
 >
> Yep, sounds good. A slightly more elaborate description of the binding
> inspired by the gpio.txt document would be the way to do that.
>
Ok, will add more elaborate documentation for this in the core
bindings.
