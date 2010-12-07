From: "Luca Ceresoli" <luca@lucaceresoli.net>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Tue,  7 Dec 2010 11:29:59 +0100
Message-ID: <LD1ZTZ$A8E18B744A1EDB29645809E1CAA11B96@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpa1.aruba.it ([62.149.128.210]:49836 "HELO smtpw1.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754655Ab0LGKaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 05:30:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: notasas@gmail.com

Luca Ceresoli wrote:
> While I thank you for you proposed solution, I see it does not work here.
> In fact I commented the #define CONFIG_MTD_NAND_OMAP_HWECC and left
> MTD_NAND_OMAP_PREFETCH disabled as it previously was, and got compilation
> errors:

Wrong, sorry. Your solution compiles and works. I had another change in that
file that broke compilation.

Nevertheless, it's not clear to me whether the long-term direction is to
switch to HWECC, and if it is expected to work in current builds, or if
SWECC in here to stay.

Thanks,
Luca


