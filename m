From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: sdio cmd53 doesn't work on omap 2430sdp
Date: Wed, 21 May 2008 18:18:27 +0530
Message-ID: <007901c8bb40$f8b8a290$538918ac@ent.ti.com>
References: <200805211521.10604.dmytro.chumak@inobject.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:54779 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbYEUMsn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2008 08:48:43 -0400
In-Reply-To: <200805211521.10604.dmytro.chumak@inobject.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmytro.chumak@inobject.com, linux-omap-open-source@linux.omap.com
Cc: linux-omap@vger.kernel.org

Hi,

Please use the vger list.

It seems like you are getting DTO on CMD53.

One thing you might want to check is did the card configuration path went fine before you issue CMD53.
Before your card driver issues CMD53, I guess the SDIO core issues a series of CMD52 to read the card capabilities and
Setup the bus width etc... Does these go through fine for the card you are using? Does the core detect the new SDIO card?

Regards,
Madhu




> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com 
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> Behalf Of Dmitriy Chumak
> Sent: Wednesday, May 21, 2008 5:51 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: sdio cmd53 doesn't work on omap 2430sdp
> 
> Hi *,
> 
> I write an SDIO driver on OMAP 2430SDP platform.
> 
> I have two question related to MMC subsystem:
> 
>     1. When I issue sdio_readw (or other function that ends up
>        using CMD53 sdio command) - it hangs. This happens because func
>        mmc_wait_for_req waits for request completion that 
> should be signaled
>        by calling mmc_wait_done. mmc_wait_done is indirectly 
> called from
>        mmc_omap_cmd_done if condition "host->data == NULL || 
> cmd->error"
>        (file: drivers/mmc/host/omap_hsmmc.c, line: 273) is 
> true. In my case
>        the above condition is not true because host->data is 
> not NULL and
>        cmd->error is NULL. Why this could be happen. Which 
> code is responsible
>        for setting host->data to NULL in case of successful 
> sdio command
>        completion?
> 
>     2. Also when I issue sdio_readw - I get an error status 108001 in
>        mmc_omap_irq. If I've decoded it correctly it means CC, ERR and
>        DATA_TIMEOUT. What does it means and when this could 
> be happened?
>        
> 
> Best regards,
> 
> Dmitriy
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 

