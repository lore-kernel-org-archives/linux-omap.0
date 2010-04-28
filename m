From: Rick Ball <rball@AESAustin.com>
Subject: RE: Unable to build for omap3_evm_defconfig using latest
 kernel-omap3 git
Date: Wed, 28 Apr 2010 18:26:55 +0000
Message-ID: <4B8557E2E5753944B2BB2E52F7C2A30C02C0C858@MAIL.AES.local>
References: <4B8557E2E5753944B2BB2E52F7C2A30C02C0C7E0@MAIL.AES.local>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322A8A0A6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.ascendant-es.com ([209.12.206.138]:13750 "EHLO
	mail.aesasutin.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755920Ab0D1S07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 14:26:59 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322A8A0A6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

OK, thanks - I thought that the 'integration' kernel for OMAP3 would be my best choice, based on the statement "TI integration tree is in general the most up-to-date version of the kernel for a TI platform since all necessary sub systems have been pre-integrated." from the OMAPedia wiki at http://omappedia.org/wiki/Linux_Kernel_Int_Trees. 

Rick

-----Original Message-----
From: Gadiyar, Anand [mailto:gadiyar@ti.com] 
Sent: Wednesday, April 28, 2010 10:53 AM
To: Rick Ball; linux-omap@vger.kernel.org
Subject: RE: Unable to build for omap3_evm_defconfig using latest kernel-omap3 git

Rick Ball wrote:
> I get the following error when attempting to build a kernel for the 
> default config of the OMAP3 EVM board with the latest 'git' from:
> 
> git://dev.omapzoom.org/pub/scm/integration/kernel-omap3.git
> 

...

> 
> Am I doing something wrong here?  Am I mistaken in thinking that 
> compiling for this board should work?

Yes, you're using the wrong kernel.

Use the linux-omap kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

Or Linus' tree directly:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

The one you're using is an internal development tree on which the OMAP3 EVM board is not well supported.

- Anand
