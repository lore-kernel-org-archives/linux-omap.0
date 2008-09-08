From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: powering up the mmc controller on 3430
Date: Sun, 7 Sep 2008 20:49:49 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036553308D@dlee02.ent.ti.com>
References: <57314e840809071219w71ec6e40ja6a8bf8e05a876c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35049 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbYIHBt4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 21:49:56 -0400
In-Reply-To: <57314e840809071219w71ec6e40ja6a8bf8e05a876c1@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Budhee Jamaich <budheej@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> I have one problem - in 2.6.14 we used the enable_mmc_power function,
> which is completely gone in 2.6.24, and i can't seem to find any
> reasonable replacement. could you please assist me how can I power up
> the mmc controller in 2.6.24 ?
>
> (we have legacy reasons for not using the in-tree mmc driver, which we
> will one day resolve, but now i really need to power up the controller
> from within our driver..)

I believe the driver now calls this via its platform data in arch/arm/mach-omap2/.  Same sequence but now a bit more generalized from the external driver point of view.

Regards,
Richard W.

