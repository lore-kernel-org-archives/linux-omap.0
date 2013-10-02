From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC PATCH] i2c: omap: Clear ARDY bit twice
Date: Wed, 2 Oct 2013 14:48:35 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73D1EA70A@DLEE11.ent.ti.com>
References: <1380711526-20365-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41614 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab3JBOsh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 10:48:37 -0400
In-Reply-To: <1380711526-20365-1-git-send-email-taras.kondratiuk@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>, "Balbi, Felipe" <balbi@ti.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Taras Kondratiuk [mailto:taras.kondratiuk@linaro.org]
> Sent: Wednesday, October 02, 2013 5:59 AM
> To: Balbi, Felipe
> Cc: Strashko, Grygorii; Woodruff, Richard; linux-omap@vger.kernel.org; Taras
> Kondratiuk
> Subject: [RFC PATCH] i2c: omap: Clear ARDY bit twice
 
> Initially commit cb527ede1bf6ff2008a025606f25344b8ed7b4ac
> "i2c-omap: Double clear of ARDY status in IRQ handler"
> added a workaround for undocumented errata ProDB0017052.
> But then commit 1d7afc95946487945cc7f5019b41255b72224b70
> "i2c: omap: ack IRQ in parts" refactored code and missed one of ARDY
> clearings. So current code violates errata.
> It causes often i2c bus timeouts on my Pandaboard.

History of this was during OMAP3 a couple phone ramps were fixed with path.

Another SOC (non-OMAP) which uses same I2C IP had clear HW root cause in its integration to SOC.

When stuck at customer I went through other SOC erratas and tried them when OMAP did not work.

This was found to be robust and did exist in RTL versions used as such fix was accepted and used on most end customers in that time frame.

At 'that time' there was some internal process blockages around getting waveforms on OMAP integration which kept fix from sticking in errata.

Regards,
Richard W.

