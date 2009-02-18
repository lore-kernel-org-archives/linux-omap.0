From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: kexec on Nokia Internet Tablets
Date: Wed, 18 Feb 2009 10:21:31 +0200
Message-ID: <20090218102131.76d54606.jhnikula@gmail.com>
References: <20090217213228.GH24800@guug.org>
	<20090217214612.GB11928@atomide.com>
	<20090217215848.GJ24800@guug.org>
	<20090217220936.GD11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:46705 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZBRISx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 03:18:53 -0500
Received: by ewy14 with SMTP id 14so2592196ewy.13
        for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2009 00:18:51 -0800 (PST)
In-Reply-To: <20090217220936.GD11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Otto Solares <solca@guug.org>, linux-omap@vger.kernel.org

On Tue, 17 Feb 2009 14:09:36 -0800
Tony Lindgren <tony@atomide.com> wrote:

> > > Well since the LCD is on, you could write a little function that
> > > writes the output to the LCD. You just need to find out the
> > > virtual address of the LCD and then add a function for displaying
> > > fonts.. Pretty easy to do.
> > 
> > Ok, btw do you known a function name I should patch with the
> > debugging output?
> 
> We have the DEBUG_LL patch in l-o tree that's for low-level debug
> output to serial port. You could could add a function called
> printlcd() and call that instead of printascii().
> 
Haven't tried but how about easier option CONFIG_MTD_OOPS? I.e. using
Maemo root device /dev/mtdblock4 for console=ttyMTD4 and then analyze
the partion afterward by booting root from sd card.


Jarkko
