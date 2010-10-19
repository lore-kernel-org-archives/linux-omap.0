From: Anand Gadiyar <gadiyar@ti.com>
Subject: linux-next - multi-omap image fails to boot on omap3/4
Date: Tue, 19 Oct 2010 20:19:35 +0530
Message-ID: <4CBDAFFF.2030409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33473 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752644Ab0JSOtv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 10:49:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 4so595255pwj.5
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 07:49:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

linux-next, as of 20101019, built with the omap2plus_defconfig fails to 
boot on omap3 and omap4. (I've disabled CONFIG_ARCH_OMAP2 or 
CONFIG_SWP_EMULATE to get the image to build). Building with only 
ARCH_OMAP3 allows the resultant image to boot up on OMAP3. Likewise,
an image built with only ARCH_OMAP4 boots up on OMAP4 boards.

earlyprintk does not provide any additional prints after
"Uncompressing Linux... done, booting the kernel."

Any ideas where to look?


- Anand
