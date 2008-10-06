From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Current git head oops'es at boot on Overo
Date: Mon, 6 Oct 2008 11:26:54 -0700
Message-ID: <5e088bd90810061126g75ff7768k8fa768751a31e379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:1488 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYJFS0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 14:26:55 -0400
Received: by yx-out-2324.google.com with SMTP id 8so449455yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 11:26:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Build is stock 62c36fdd962de2db5d62a326490913f41c442a5c, no additional patches.

Without DEBUG_LL, boot silently fails. With DEBUG_LL, one can see that
the failure is due to a NULL pointer dereference in musb.

I suspect that the root cause is related to:

<3>i2c_omap i2c_omap.1: controller timed out
<4>twl4030_usb: probe of twl4030_usb failed with error -22

Adding David Brownell's i2c-omap timeout workaround patch eliminates
this error and the boot then fails on EHCI.

I disabled EHCI in defconfig and was able to get the boot to complete.
 However unlike others, I find that musb is not functional -- and the
trick of disconnecting the USB cable and then reconnecting it does not
work.

Steve
