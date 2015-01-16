From: Paolo Pisati <p.pisati@gmail.com>
Subject: am335x boneblack memory size and dtb: is memory live patched?
Date: Fri, 16 Jan 2015 10:04:45 +0100
Message-ID: <20150116090445.GA23266@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:35259 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbbAPJEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 04:04:49 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so19103172wes.2
        for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2015 01:04:48 -0800 (PST)
Received: from gmail.com (2-230-238-136.ip204.fastwebnet.it. [2.230.238.136])
        by mx.google.com with ESMTPSA id g2sm5202513wjn.11.2015.01.16.01.04.46
        for <linux-omap@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 01:04:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Lately i've been trying to track down a panic i hit when i pass the "mem=256M"
option to a 3.16 kernel on a bleaglebone black, and i noticed this:

dtc -I dtb ./arch/arm/boot/dts/am335x-boneblack.dtb
...
        memory {
                device_type = "memory";
                reg = <0x80000000 0x10000000>;
        };
...

that's 256M of memory while the beaglebone black has 512M, does it mean the dtb
is live patched (by u-boot?) before being passed to the kernel?
-- 
bye,
p.
