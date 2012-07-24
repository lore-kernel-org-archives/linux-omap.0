From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: NFS mount issue with OMAP4 on linux-next
Date: Tue, 24 Jul 2012 12:23:16 +0530
Message-ID: <CANfBPZ_EJJk_HRCpUpZHauJCjJ8HgQO=YC104roEcKsAAw=iMA@mail.gmail.com>
References: <500E3B9B.9080702@ti.com> <500E3E4E.1060809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:46028 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754727Ab2GXGxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 02:53:37 -0400
Received: by obcva7 with SMTP id va7so10681379obc.6
        for <linux-omap@vger.kernel.org>; Mon, 23 Jul 2012 23:53:36 -0700 (PDT)
In-Reply-To: <500E3E4E.1060809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jul 24, 2012 at 11:48 AM, Archit Taneja <a0393947@ti.com> wrote:
> Hi,
>
> Comparing with working logs, I see this difference:
>
> [    1.502166] spi spi1.0: no RX DMA engine channel for McSPI
> [    1.507904] omap2_mcspi omap2_mcspi.1: can't setup spi1.0, status -11
> [    1.514862] omap2_mcspi omap2_mcspi.1: can't create new device for ks8851
>
> I guess that's why it isn't working?
>
Most likely yes. SPI is needed for ethernet on OMAP4.
Please include this patch in your build and check..
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=55936cdfaaf11ac352b56bc58e42d6661e65ee13
