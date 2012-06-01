From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: latest kernel for am35xx
Date: Fri, 1 Jun 2012 09:20:03 -0700
Message-ID: <20120601162003.GA28393@animalcreek.com>
References: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com>
 <CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com>
 <CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
 <20120601033605.GB520@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:39641 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964978Ab2FAQUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 12:20:05 -0400
Content-Disposition: inline
In-Reply-To: <20120601033605.GB520@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxim Podbereznyy <lisarden@gmail.com>
Cc: Anil Kumar <anilkumar880@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

[Somehow this didn't get out the first time so resending.]

On Thu, May 31, 2012 at 08:36:05PM -0700, Mark A. Greer wrote:
> On Thu, May 31, 2012 at 10:08:44AM +0300, Maxim Podbereznyy wrote:
> > Hi!
> 
> Hi Maxim
> 
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git
> > Does anyone knows a working branch/tag for am3517evm? I need the board
> > boots fine with Ethernet enabled and working.
> > 
> > I read a few messages at e2e forum and all of them report about broken
> > features.. I need wl1271 support in the kernel therefore I have to use
> > on the latest kernels.
> 
> There are several issues with the am35x code in the current community.
> However, if you checkout k.o. v3.4, use omap2plus_defconfig, enable
> CONFIG_TI_DAVINCI_EMAC, and add 'nohlt' to the cmdline, you will be
> able to boot the am3517evm.  Don't try a Suspend-to-RAM though.
> 
> Mark
> --
