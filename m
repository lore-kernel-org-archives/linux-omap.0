From: Dmitriy Chumak <dmytro.chumak@inobject.com>
Subject: sdio cmd53 doesn't work on omap 2430sdp
Date: Mon, 26 May 2008 12:27:57 +0300
Message-ID: <200805261227.57990.dmytro.chumak@inobject.com>
Reply-To: dmytro.chumak@inobject.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kyiv.inobject.com ([62.221.40.190]:57165 "EHLO
	kyiv.inobject.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYEZJ2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 May 2008 05:28:06 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi *,

Sorry for bothering all of you with my problem again.

I've asked it in linux-omap-open-source@linux.omap.com but have not got
some working solution. Maybe here somebody could help me.

I write an SDIO driver on OMAP 2430SDP platform.

I have three questions related to MMC subsystem:

    1. When I issue sdio_writesb - it hangs. This happens because func
    mmc_wait_for_req waits for request completion that should be
    signaled by calling mmc_wait_done. mmc_wait_done is indirectly
    called from mmc_omap_cmd_done if condition "host->data == NULL ||
    cmd->error" (file: drivers/mmc/host/omap_hsmmc.c, line: 273) is
    true. In my case the above condition is not true because
    host->data is not NULL and cmd->error is NULL. Why this could be
    happen. Which code is responsible for setting host->data to NULL
    in case of successful sdio command completion?

    2. Also when I issue sdio_writesb - I get an error status 108001
    in mmc_omap_irq. If I've decoded it correctly it means CC, ERR and
    DATA_TIMEOUT. What does it means and when this could be happened?
       
    3. When I issue sdio_readw - it simply hangs, even without any
    call to mmc_omap_irq.

How can I fix these?


Thanks in advance,
Dmitriy
