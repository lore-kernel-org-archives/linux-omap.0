From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Question about mmc4 initialization on OMAP5432
Date: Tue, 8 Oct 2013 12:48:26 -0400
Message-ID: <5254375A.6050507@ti.com>
References: <525432D2.9010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab3JHQs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 12:48:28 -0400
In-Reply-To: <525432D2.9010907@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Baozi <baozich@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 08 October 2013 12:29 PM, Chen Baozi wrote:
> Hi all,
> 
> I have got a problem when booting dom0 kernel for Xen on OMAP5432 uEVM.
> With a recent patch, Xen hypervisor is avoid to map "disabled" device
> memory for dom0. In omap5-uevm.dts, we have got the &mmc4 node marked as
> "disabled". So the Xen won't populate <0x480d1000 0x400> memory region
> to the dom0. If dom0 is trying to access any memory address in this
> area, the hypervisor would be panic with a tranlation fault. However, it
> turns out that even the mmc4 is disabled in omap5-uevm.dts, Linux kernel
> is trying to access the 0x480d1010 when booting, which then leads a
> hypervisor panic as mentioned.
> 
> The only point I know right now is that the 0x480d1010 is accessed by
> the omap_hwmod_read(). However, what makes me confused is how the dom0
> kernel called omap_hwmod_read() to access 0x480d1010 while the mmc4 is
> disabled. I guess it might relate to hard coded omap_hwmod structure but
> have no idea what happen exactly when dom0 access the address due to the
> lack of calling stack information when booting Xen hypervisor.
> 
There is no hard-coding rather a different requirement why
hwmod accesses the IP space. DT disabled is will ensure that the device
won't get created but hwmod bus initially tries to put all the
supported IPs in sane hardware state by doing reset on those
IPs.

We have proposals to address than in future where such resets are
moved with device/driver probe etc to avoid such issues. Actually
MMC4 is more for SDIO kind of usecase so you might even get rid
of that in your case.

Regards,
Santosh

