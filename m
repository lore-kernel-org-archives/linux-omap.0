From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: reset handling in am335x hwmod data
Date: Fri, 17 May 2013 20:10:56 +0200
Message-ID: <87vc6hlbnz.fsf@dell.be.48ers.dk>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
	<20130517135022.GH14133@arwen.pp.htv.fi> <877gixsfdz.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:34898 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3EQSLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 14:11:02 -0400
Received: by mail-ea0-f171.google.com with SMTP id b15so2757175eae.16
        for <linux-omap@vger.kernel.org>; Fri, 17 May 2013 11:11:01 -0700 (PDT)
In-Reply-To: <877gixsfdz.fsf@linaro.org> (Kevin Hilman's message of "Fri, 17
	May 2013 10:08:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: balbi@ti.com, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

>>>>> "Kevin" == Kevin Hilman <khilman@linaro.org> writes:

 >> In this case, we cannot reset that bank, otherwise Starter Kit will
 >> never boot in mainline. Bad PCB design, I know, but it's not something
 >> we can change now :-)

 Kevin> FWIW, we've seen this before (GPIO connected to PMIC reset is a
 Kevin> fun one), and this is why we have omap_hwmod_no_setup_reset().

Yes, but there's no dts bindings for this, and from a quick test the
reset handling happens before the device tree is probed.

-- 
Bye, Peter Korsgaard
