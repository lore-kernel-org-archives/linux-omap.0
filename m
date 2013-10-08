From: Chen Baozi <baozich@gmail.com>
Subject: Question about mmc4 initialization on OMAP5432
Date: Wed, 09 Oct 2013 00:29:06 +0800
Message-ID: <525432D2.9010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49931 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab3JHQ3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 12:29:11 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so9083159pad.21
        for <linux-omap@vger.kernel.org>; Tue, 08 Oct 2013 09:29:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I have got a problem when booting dom0 kernel for Xen on OMAP5432 uEVM.
With a recent patch, Xen hypervisor is avoid to map "disabled" device
memory for dom0. In omap5-uevm.dts, we have got the &mmc4 node marked as
"disabled". So the Xen won't populate <0x480d1000 0x400> memory region
to the dom0. If dom0 is trying to access any memory address in this
area, the hypervisor would be panic with a tranlation fault. However, it
turns out that even the mmc4 is disabled in omap5-uevm.dts, Linux kernel
is trying to access the 0x480d1010 when booting, which then leads a
hypervisor panic as mentioned.

The only point I know right now is that the 0x480d1010 is accessed by
the omap_hwmod_read(). However, what makes me confused is how the dom0
kernel called omap_hwmod_read() to access 0x480d1010 while the mmc4 is
disabled. I guess it might relate to hard coded omap_hwmod structure but
have no idea what happen exactly when dom0 access the address due to the
lack of calling stack information when booting Xen hypervisor.

Thanks a lot.

Chen Baozi
