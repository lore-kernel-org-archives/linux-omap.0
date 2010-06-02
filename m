From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Wed, 2 Jun 2010 14:46:06 +0300
Message-ID: <20100602144606.4287c438.jhnikula@gmail.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
	<20100311224812.GU2900@atomide.com>
	<4C062DD4.2050701@cioinfoindus.fr>
	<20100602112130.GG5980@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:7476 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab0FBLnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 07:43:37 -0400
Received: by ey-out-2122.google.com with SMTP id d26so305611eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Jun 2010 04:43:35 -0700 (PDT)
In-Reply-To: <20100602112130.GG5980@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org

On Wed, 2 Jun 2010 14:21:30 +0300
Tony Lindgren <tony@atomide.com> wrote:

> > How can I call  omap_mux_init_signal()
> > from external driver compiled as module ?
> > 
> > cause the function is not in the standard path include files
> > and is not exported
> 
> You can't that's the whole idea :)
> 
> Instead, please do the muxing in the board-*.c file for all the
> pins, or for the device when you initialize the platform data.
> 
> The muxing of pins is board specific, and doing it in the board-*.c
> files allows us to free the memory for the unused pin data. Note
> that you can also mux using the kernel cmdline if you have something
> non-standard connected to your board pins.
> 
Side note.

How about add-on cards for e.g. BeagleBoard? It would be nice feature
if a kernel module for that particular add-on card can do the muxing
without needing to specify them on cmdline. I.e. if you are switching
between cards there is no need to figure out new cmdline for each of
them. For me even "rootwait" is sometimes too difficult to remember :-)


-- 
Jarkko
