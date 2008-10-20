From: Seth Forshee <seth.forshee@gmail.com>
Subject: AUTO_EXTVOLT on OMAP2430
Date: Mon, 20 Oct 2008 00:07:26 -0500
Message-ID: <20081020050726.GA12891@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:27026 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbYJTFHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 01:07:49 -0400
Received: by wx-out-0506.google.com with SMTP id h27so744794wxd.4
        for <linux-omap@vger.kernel.org>; Sun, 19 Oct 2008 22:07:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm working with what basically amounts to an older version of the linux-omap
kernel with substantial modifications.  I found that in some situations I was
getting about 4 mA more current draw during suspend than at other times.  This
was ultimately being caused by some of the code that runs in SRAM masking off
the PRCM_VOLTCTRL[AUTO_EXTVOLT] bit. I compared to tips in the linux-omap repo
for comparison and found the situation is the same -- the bit is set during
initialization, but will be cleared by the SRAM code that configures the SDRC.

>From reading the TRM it seems that this bit should only affect the retention
and off states, so I don't understand why it needs to be masked during SDRC
configuration.  Is there any danger in changing the mask to leave this bit
unchanged?  Or would it be safer to set this bit before suspend and clear it
after?

Thanks,
Seth
