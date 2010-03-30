From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 7/9] OMAP: Devkit8000: Fix wrong usb port on Devkit8000
Date: Tue, 30 Mar 2010 11:59:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032231D221@dbde02.ent.ti.com>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
 <1269435138-27192-8-git-send-email-weber@corscience.de>
 <20100324130001.GK29419@nokia.com> <20100329203432.GB31402@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032231D1BE@dbde02.ent.ti.com>
 <4BB1A531.10906@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab0C3G31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 02:29:27 -0400
In-Reply-To: <4BB1A531.10906@corscience.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Thomas Weber wrote:
> Hi,
> I tried to find some users but they are in holiday for a longer time or
> didn't respond.
> 
> I will try to explain the problem why I disabled the usb-port2.
> The devkit8000 has only one mini-usb-port and one usb-host port like the
> beagleboard. The usb2-port on the devkit8000 has some gpios attached for
> mmc and touchscreen. Thatswhy the mmc was not working, when the usb-ehci
> was enabled on this port.
> 
> The beagleboard has also only one usb-host exposed, but there is no
> other thing connected to the not exposed usb-port.

Yup, I've been bitten by this before on other boards. Marking the
wrong port as an EHCI port will result in 12 pads being put in the
wrong mux-mode straight away, due to the padconf settings we do in
usb-ehci.c. With 12-pads, there's a very high chance that you lose
other functionality.

The patch has my ack.

Is there a link to the schematics somewhere, so the next time we
see something like this, we can just use those as reference?

- Anand
