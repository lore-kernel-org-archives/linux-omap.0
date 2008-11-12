From: twebb <taliaferro62@gmail.com>
Subject: DVI output support for OMAP35x EVM
Date: Wed, 12 Nov 2008 12:36:14 -0500
Message-ID: <dbdb2ea60811120936h971a955t956726dd7f8db22d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:27754 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbYKLRgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 12:36:16 -0500
Received: by an-out-0708.google.com with SMTP id d40so238412and.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 09:36:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

The SDK 1.0.0 kernel for OMAP35x EVM from TI included DVI support
(480P and 720P) in the display driver.  Is there a patch that was
submitted to the l-o git that includes that support?  I'm looking to
add DVI support into the kernel I'm currently using, which is
linux-omap-2.6 (tag = v2.6.27-omap1).

Thanks,
twebb
