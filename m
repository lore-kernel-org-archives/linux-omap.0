From: Otto Solares <solca@guug.org>
Subject: kexec on Nokia Internet Tablets
Date: Tue, 17 Feb 2009 15:32:28 -0600
Message-ID: <20090217213228.GH24800@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from guug.org ([200.9.255.30]:20170 "EHLO guug.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbZBQVhh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Feb 2009 16:37:37 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all!

I want to make kexec work on current Nokia Internet Tablets but
maybe someone here have a clue or better if a patch :)

When I run a kexec enabled linux-omap kernel and try to boot the
production Maemo kernel or a linux-omap kernel I only succeed if
the serial-console flag in r&d mode is set, if not the device
just hangs.

It seems as a timing problem because if I insert small delays to
the kexeced kernel via CONFIG_BOOT_PRINTK_DELAY it works too 
without the serial-console flag set.

Any idea what to debug or where to start?

Thanks.

-otto
