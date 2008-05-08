From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [RFC/PATCH 0/3] OMAP3 EVM: enable ethernet support
Date: Thu, 8 May 2008 09:47:53 -0700
Message-ID: <5e088bd90805080947u5ffc7188h4a1df0309841b767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:34818 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbYEHQrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 12:47:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so869811fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2008 09:47:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This series of patches enables ethernet support on the OMAP3 EVM.  It
has been tested with an x11 image and I was able to successfully
browse the web and download OE packages.

The first patch has been submitted to linux-netdev by Nishant Kamat
and is currently under consideration there.  The second two patches
are linux-omap specific.

I'm posting this series for comment while we wait for acceptance of
the first patch.
