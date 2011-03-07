From: Orjan Friberg <of@flatfrog.com>
Subject: Re: OMAP 3730 200 MHz SDRAM config
Date: Mon, 7 Mar 2011 16:33:33 +0100
Message-ID: <4D74FACD.2040500@flatfrog.com>
References: <4D74EFB8.9030406@flatfrog.com> <6B47CFCE-FBCF-4CED-A1AB-E43C619FD174@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:56335
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751160Ab1CGPde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 10:33:34 -0500
In-Reply-To: <6B47CFCE-FBCF-4CED-A1AB-E43C619FD174@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2011-03-07 16:19, Elvis Dowson wrote:
> You probably need update x-loader. Try using the beagleboard x-loader project located at gitorious (v1.44) or the ti arago one (1.48, but not quite the latest in terms of support for beagleboard xm parts).
>
> Looking at board/omap3530beagle/omap3530beagle.c for the memory part definitions. For the XM, the Numonyx part is at 165Mhz, and the Micron part is at 200Mhz.

I'm using u-boot with a configuration header, and there I have set the 
new CTRLA, CTRLB and RFR values (and I did compare the values with the 
Micron data sheet; apart from the TCKE value they are all identical).

But are you saying that the values set by the boot loader are preserved 
by the kernel?  (In that case I wonder what the sdram-micron header file 
is for :)


Thanks,
Orjan

-- 
Orjan Friberg
FlatFrog Laboratories AB
