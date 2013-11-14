From: Paolo Pisati <p.pisati@gmail.com>
Subject: 3.12: omap4: cpuidle: solid hangs at boot
Date: Thu, 14 Nov 2013 12:04:45 +0100
Message-ID: <20131114110445.GB4594@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:44919 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab3KNLEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 06:04:49 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so1751519wgg.16
        for <linux-omap@vger.kernel.org>; Thu, 14 Nov 2013 03:04:48 -0800 (PST)
Received: from gmail.com (2-230-238-136.ip204.fastwebnet.it. [2.230.238.136])
        by mx.google.com with ESMTPSA id s3sm97909152eeo.3.2013.11.14.03.04.46
        for <linux-omap@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 03:04:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Vanilla 3.12 multi_v7_defconfig + cpu_idle result in a solid hang on my pandaes
board: has anyone experienced it before? is cpu_idle safe on omap4?

same kernel boots fine on omap3 and some other arm boards fwiw.
if you want to reproduce it:

config: http://people.canonical.com/~ppisati/3.12_armv7multi_cpuidle/config

zImage: http://people.canonical.com/~ppisati/3.12_armv7multi_cpuidle/zImage

boot log: http://paste.ubuntu.com/6415293/
-- 
bye,
p.
