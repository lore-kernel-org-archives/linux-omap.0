From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch updates
Date: Wed, 13 May 2009 09:45:24 -0700
Message-ID: <87pred6jff.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:27815 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759361AbZEMQpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 12:45:25 -0400
Received: by rv-out-0506.google.com with SMTP id f9so478421rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 09:45:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

FYI... this small set of updates has been pushed to the pm branch[1].
This will be the last round of updates before the rebase to 2.6.30.

Aaro Koskinen (1):
      OMAP3: PM: Save and restore I2C wakeup sources

Kevin Hilman (1):
      OMAP3: PM: set MUSB OTG into force-idle at boot

Phil Carmody (2):
      OMAP3: PM: Don't do unnecessary searches in omap_sr_vdd*_autocomp_store
      OMAP3: PM: Early exit on invalid parameters

Rajendra Nayak (1):
      OMAP3: SR: Fix SR driver to check for omap-pm return values

Russ Dill (1):
      Allow OMAP3 GPIO wakeup from power off.


[1] See branch named 'pm' in this tree:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
