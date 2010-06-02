From: Tony Lindgren <tony@atomide.com>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Wed, 2 Jun 2010 14:21:30 +0300
Message-ID: <20100602112130.GG5980@atomide.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50046 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859Ab0FBLVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 07:21:33 -0400
Content-Disposition: inline
In-Reply-To: <4C062DD4.2050701@cioinfoindus.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Epinat <laurent.epinat@cioinfoindus.fr>
Cc: linux-omap@vger.kernel.org

* Laurent Epinat <laurent.epinat@cioinfoindus.fr> [100602 13:03]:
> Hello all
> 
> 
> How can I call  omap_mux_init_signal()
> from external driver compiled as module ?
> 
> cause the function is not in the standard path include files
> and is not exported

You can't that's the whole idea :)

Instead, please do the muxing in the board-*.c file for all the
pins, or for the device when you initialize the platform data.

The muxing of pins is board specific, and doing it in the board-*.c
files allows us to free the memory for the unused pin data. Note
that you can also mux using the kernel cmdline if you have something
non-standard connected to your board pins.

Regards,

Tony
