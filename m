From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: No console output (omap-3.2 branch)
Date: Thu, 26 Jan 2012 11:13:00 +0100
Message-ID: <jfr8vc$i8f$1@dough.gmane.org>
References: <jbvod7$rj2$1@dough.gmane.org> <4F207EFE.1010902@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58958 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab2AZKNR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 05:13:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RqMKS-0000nB-G7
	for linux-omap@vger.kernel.org; Thu, 26 Jan 2012 11:13:16 +0100
Received: from x23.theoinf.tu-ilmenau.de ([141.24.211.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 11:13:16 +0100
Received: from andre.puschmann by x23.theoinf.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 11:13:16 +0100
In-Reply-To: <4F207EFE.1010902@yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 01/25/2012 11:15 PM, Frank Agius wrote:
> On 12/10/2011 8:55 AM, Andre Puschmann wrote:
>> Hi list, Steve,
>>
>> I am trying to boot a kernel I built (using omap2plus_defconfig) based
>> on Steve's omap-3.2 branch without much success.
>>
>> I don't get any console output after Uboot finished uncompressing the
>> kernel. Is there anything I need to configure? The kernel image based on
>> Tony's tree boots fine on the same hardware (Gumstix Overo Tide)
>> (despite having MMC issues as mentioned earlier).
> 
> I ran into the same problem you described. Steve's tree has some patches
> that are not in mainline 3.2.  I tracked the hang down to one of those
> patches that added support for 720Mhz capable hardware.  The
> kernel reads the status register and determines that the CPU can support
> 720Mhz (omap3_check_features).  From what I can tell, the check is done
> correctly (variable status in omap3_check_features is set to 0x08, which
> looks like the right bit for 720Mhz support).  Since the kernel thinks
> that 720Mhz is supported, it calls omap3_opp_enable_720Mhz (file
> opp3xx_data.c).  The kernel dies silently when it calls the opp enable
> for 720Mhz, at or near line 178:
> 
> 176                 pdev = &oh_mpu->od->pdev;
> 177
> 178                 r = opp_enable(&pdev->dev, 720000000);
> 
> That's as far as I can take the debug.  I'm going to disable the check
> for 720Mhz in my local tree until this can get sorted out.

Just wanted to mention that the bug is still present here, too.
Interestingly, the same code seems to work in the omap-3.0pm tree and
the kernel boots fine. So disabling 720MHz support might just hide the
real cause.

-Andre

