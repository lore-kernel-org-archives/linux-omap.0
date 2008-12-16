From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Issue: TWL4030-USB
Date: Wed, 17 Dec 2008 01:53:06 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127BDF7@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com>
 <200812111524.57050.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60433 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759659AbYLPUXO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 15:23:14 -0500
In-Reply-To: <200812111524.57050.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


I have not been following much of the TWL4030 USB development.
I came across this code:

<snip-start>
static int twl4030_set_peripheral(struct otg_transceiver *x,
                struct usb_gadget *gadget)
{
...
if (!gadget) {
>>>>>       omap_writew(0, OTG_IRQ_EN);
...
<snip-end>

This code will not work for OMAP3. There is no OHCI OTG block on OMAP3.


Regards,
Vikram 

