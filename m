From: Tony Lindgren <tony@atomide.com>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Thu, 3 Jun 2010 17:06:43 +0300
Message-ID: <20100603140642.GI30622@atomide.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <4C07B136.8010008@cioinfoindus.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab0FCOGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 10:06:46 -0400
Content-Disposition: inline
In-Reply-To: <4C07B136.8010008@cioinfoindus.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Epinat <laurent.epinat@cioinfoindus.fr>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>

* Laurent Epinat <laurent.epinat@cioinfoindus.fr> [100603 16:36]:
> 
> I would like one basic configuration for the modules with (twl,net,flash,.. all on the COM's)
> and for the rest, external driver for extra functionalities on the support board.
> 
> This is why I need to change the mux pins dynamically by the driver module.

If you really want to do it after the system has booted instead of passing
the desired muxing in the kernel cmdline, you could just do some
shell scripts to echo 0xXXXX > /sys/kernel/debug/omap_mux/whateverpin..

Tony
