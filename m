From: Tony Lindgren <tony@atomide.com>
Subject: Gadget regression with enabling of MUSB babble interrupt handling
Date: Thu, 19 Jun 2014 02:56:55 -0700
Message-ID: <20140619095655.GA29055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33812 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850AbaFSJ45 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2014 05:56:57 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

Hi,

Looks like commit ca88fc2ef0d7 (usb: musb: add a work_struct
to recover from babble errors) causes MUSB gadgets to stop
enumerating at least on omap3. Reverting the the commit fixes
the issue.

Regards,

Tony
