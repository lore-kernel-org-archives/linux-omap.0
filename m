From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v3 0/2] omap: serial: handle abort on empty rx fifo read
Date: Tue, 1 Dec 2009 18:50:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1E2F@dbde02.ent.ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbZLANU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:20:29 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nB1DKXCV004253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Dec 2009 07:20:36 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nB1DKWTF026462
	for <linux-omap@vger.kernel.org>; Tue, 1 Dec 2009 18:50:33 +0530 (IST)
In-Reply-To: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pandita, Vikram wrote:
> 
> introduce OMAP3_HAS_UART_NO_EMPTY_FIFO_READ feature
> 
> this feature is set for omap3630 and omap4 currently as 
> empty uart rx fifo read causes an abort
> 
> check on this feature on omap3630 and omap4 for now and extend for future
> vairants in future
> 
> Patch history:
> V1: initial implementation
> 	http://patchwork.kernel.org/patch/60785/
> 	http://patchwork.kernel.org/patch/60786/
> 
> V2: incorporate review comments from Alan Cox
> 	http://patchwork.kernel.org/patch/60785/
> 	to remove 8250.c file changes by override serial_in
> 	No 8250 driver change required now
> 
> V3: incorporate review comments
> 	khilman: make function override only for affected silicons
> 	nishant m: interoduce has_feature check, rather than cpu_is
> 	anand g: minor commit message change
> 
> Vikram Pandita (2):
>   omap: introduce uart_no_empty_fifo_read feature
>   omap: serial: fix non-empty uart fifo read abort
> 
>  arch/arm/mach-omap2/id.c              |    7 +++++++
>  arch/arm/mach-omap2/serial.c          |   21 +++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
>  3 files changed, 30 insertions(+), 0 deletions(-)
> 

Ping?

Tony,

These two patches are the only ones pending to make 3630 platforms boot
up nicely. Would you consider taking them?

- Anand
