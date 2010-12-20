From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Is changing serial from /dev/ttySx to /dev/ttyOx a good idea?
Date: Mon, 20 Dec 2010 15:46:12 +1300
Message-ID: <201012201546.12319.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:53934 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751281Ab0LTCqO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Dec 2010 21:46:14 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All

With the change to the new omap-serial stuff, the device names have changed 
from /dev/ttySn to /dev/ttyOn.

Using the "fit/form/function" argument, this would seem to be a bad idea. 

The kernel does not exist in a vacuum. It is surrounded by u-boot scripts, 
command line options, init scripts etc etc. Flipping back and forth between 
2.6.36 and 2.6.37 kernels for testing purposes needs these to be changed. 
Annoying and anti-productive.

Isn't it just better to just replace the ttyOn name with ttyS. That would make  
a far smoother transition.

Thoughts?

-- CHarles






