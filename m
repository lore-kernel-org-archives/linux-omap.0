From: Bill Gatliff <bgat@billgatliff.com>
Subject: Do defconfigs work for 2.6.32-rc5 mainline kernels?
Date: Fri, 30 Oct 2009 16:38:32 -0500
Message-ID: <4AEB5CD8.8060603@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:39606 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130AbZJ3ViW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 17:38:22 -0400
Received: by ywh40 with SMTP id 40so3092417ywh.33
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 14:38:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to build a kernel for beagleboard, using the defconfig found
in 2.6.32-rc5 and the 2.6.32-rc5 source code.

Said kernel hangs after the uncompressor, I'm just trying to figure out
if this is a known issue or not.  The defconfig in the linux-omap tree
does seem to work with the linux-omap source code, FWIW...


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

