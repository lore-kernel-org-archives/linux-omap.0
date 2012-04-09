From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: shouldn't OMAP4 keypad depend on OMAP4?
Date: Mon, 9 Apr 2012 15:59:50 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1204091557260.5849@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:36660 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2DIU51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 16:57:27 -0400
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1SHKkm-0004UX-09
	for linux-omap@vger.kernel.org; Mon, 09 Apr 2012 15:59:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


  from current mainline kernel source, drivers/input/keyboard/Kconfig

... snip ...
config KEYBOARD_OMAP
        tristate "TI OMAP keypad support"
        depends on (ARCH_OMAP1 || ARCH_OMAP2)
        help
          Say Y here if you want to use the OMAP keypad.

          To compile this driver as a module, choose M here: the
          module will be called omap-keypad.

config KEYBOARD_OMAP4
        tristate "TI OMAP4 keypad support"
        help
          Say Y here if you want to use the OMAP4 keypad.

          To compile this driver as a module, choose M here: the
          module will be called omap4-keypad.
... snip ...

  shouldn't that second entry depend on whatever is equivalent to
OMAP4, like the entry before it?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
