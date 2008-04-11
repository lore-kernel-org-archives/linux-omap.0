From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: Problems with 2430 NAND prefetch engine
Date: Fri, 11 Apr 2008 14:10:18 -0700
Message-ID: <a46a26fd0804111410x2b2e580cw833480139ec2e666@mail.gmail.com>
References: <a46a26fd0804081733i469936d4m3315f3bb3270ff5@mail.gmail.com>
	 <20080411192227.GH7717@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:64166 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760422AbYDKVKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 17:10:20 -0400
Received: by rn-out-0910.google.com with SMTP id e11so644223rng.17
        for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 14:10:19 -0700 (PDT)
In-Reply-To: <20080411192227.GH7717@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Apr 11, 2008 at 12:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Juha Kuikka <juha.kuikka@gmail.com> [080408 17:33]:
> > Hi,
>  >
>  > I am trying to use the NAND prefetch engine to speed up NAND access.
>  >
>  > In GPMC CS0 is the NAND chip. GPMC_CONFIG7_0 is set to 0x0000084c by
>  > u-boot. Hence the address for this CS should be 0x0C000000.
>  > Documentation indicates that the FIFO should be accessible in any
>  > associated chip-select region after the engine has been enabled.
>  >
>  > In linux I use ioremap() to map 0x0C000000 and use the returned
>  > pointer to access the prefetch engine FIFO.
>  >
>  > Prefetch engine is configured and started.
>  > I get FIFOEVENT interrupt from it and try to read the fifo by using
>  > this ioremap's pointer but kernel crashes with:
>  >
>  > Unhandled fault: external abort on non-linefetch (0x008) at 0xc4854000
>  > 0xc4854000 corresponds to the pointer ioremap() returned.
>  >
>  > Apparently I miss something either in HW or kernel but I cannot think
>  > of anything.
>  > Conventional access to the NAND chip through COMMAND/ADDRESS/DATA
>  > registers works ok.
>  > Any ideas would be appreciated.
>
>  Are you sure you have all the needed clocks on at this point? At least
>  gpmc_fck should be checked. Of course if access to gpmc works in
>  general, this is not the problem.

Yes, GPMC access without prefetch engine works fine so clocks are on.

I was able to solve this problem though. U-boot configured CS0 mapping
to be 128MB. If I change this to 64MB it works.
Very strange indeed.

 / Juha


-- 
Madness takes it's toll. Please have exact change.
