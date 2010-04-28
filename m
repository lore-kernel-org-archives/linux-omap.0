From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Unable to build for omap3_evm_defconfig using latest
 kernel-omap3 git
Date: Wed, 28 Apr 2010 21:23:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322A8A0A6@dbde02.ent.ti.com>
References: <4B8557E2E5753944B2BB2E52F7C2A30C02C0C7E0@MAIL.AES.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab0D1PxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 11:53:24 -0400
In-Reply-To: <4B8557E2E5753944B2BB2E52F7C2A30C02C0C7E0@MAIL.AES.local>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Ball <rball@AESAustin.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Rick Ball wrote:
> I get the following error when attempting to build a kernel 
> for the default config of the OMAP3 EVM board with the latest 
> 'git' from:
> 
> git://dev.omapzoom.org/pub/scm/integration/kernel-omap3.git
> 

...

> 
> Am I doing something wrong here?  Am I mistaken in thinking 
> that compiling for this board should work?

Yes, you're using the wrong kernel.

Use the linux-omap kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

Or Linus' tree directly:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

The one you're using is an internal development tree on
which the OMAP3 EVM board is not well supported.

- Anand
