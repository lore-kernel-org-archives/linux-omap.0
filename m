From: "Hemanth V" <hemanthv@ti.com>
Subject: User/kernel memory split
Date: Mon, 6 Jul 2009 15:23:07 +0530
Message-ID: <017301c9fe1f$91b92100$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879AbZGFJxR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jul 2009 05:53:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi All

Has anyone tried 3.5G/1.5G user/kernel memory split. 
Are there any know issues in this.

Thanks
Hemanth


arch/arm/Kconfig
choice
        prompt "Memory split"
        default VMSPLIT_3G
        help
          Select the desired split between kernel and user memory.

          If you are not absolutely sure what you are doing, leave this
          option alone!

        config VMSPLIT_3G
                bool "3G/1G user/kernel split"
        config VMSPLIT_2G
                bool "2G/2G user/kernel split"
        config VMSPLIT_1G
                bool "1G/3G user/kernel split"

