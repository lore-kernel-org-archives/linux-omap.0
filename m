From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO IRQ for OMAP35xx
Date: Wed, 28 Oct 2009 08:30:51 +0100
Message-ID: <4AE7F32B.6070007@googlemail.com>
References: <54d94f230910272337n150d4ec0kfa382d774479f10e@mail.gmail.com> <54d94f230910280002j5a4f710frd76a640f3d15aa01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:31204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbZJ1Hav (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 03:30:51 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1857301fga.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 00:30:55 -0700 (PDT)
In-Reply-To: <54d94f230910280002j5a4f710frd76a640f3d15aa01@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phaneendra Kumar Alapati <phani@embwise.com>
Cc: linux-omap@vger.kernel.org

Phaneendra Kumar Alapati wrote:
> All,
> 
> I have not seen any further discussion on the MMC_CAP_SDIO IRQ for
> OMAP3430 topic.

As nobody stepped (until now ;) ) into this discussion again, there 
was nothing to discuss. I'm still working in the background at this 
issue. I'm currently waiting for a test environment ;)

> I have a working solution for sdio irq support on omap35xx. I have
> verified and tested the functionality on omap3530evm with Marvell
> 88W8686 WLAN cards with linux kernel 2.6.31.rc7  The wifi performance
> was 12Mbps for downlink and 10Mbps for uplink. The performance results
> and stability are greatly improved compared to the sdio polling. I
> will be posting the patch soon.

Great! Yes please do so!

Best regards

Dirk


