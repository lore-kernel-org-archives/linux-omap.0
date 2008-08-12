From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB-webcam support
Date: Tue, 12 Aug 2008 16:20:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48238 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbYHLKu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 06:50:57 -0400
In-Reply-To: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hi All,
> 
> If I have a USB camera with good Linux support, can I connect it
> to omap3evm(or any omap2) and make it functional?

I don't see why not. Do you expect a problem with using it? You could
use MUSB in host or OTG mode and connect the camera to the MUSB port.

- Anand