From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Mon, 14 Mar 2011 20:10:49 -0600
Message-ID: <20110315021049.GA12819@angua.secretlab.ca>
References: <87ipvmx2ok.fsf@gmail.com>
 <1300043119-11262-1-git-send-email-bgamari.foss@gmail.com>
 <20110314192718.GG16096@angua.secretlab.ca>
 <87ipvlm91r.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65132 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab1COCKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 22:10:53 -0400
Received: by gyf1 with SMTP id 1so48136gyf.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 19:10:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ipvlm91r.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 14, 2011 at 10:06:40PM -0400, Ben Gamari wrote:
> On Mon, 14 Mar 2011 13:27:18 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> > What if the board wanted to use both the native SPI ss line as well as
> > one or more GPIOs?  You probably want to reserve cs0 for the native
> > gpio line.
> > 
> Hmm, I had thought about this and assumed it would be easiest to punt on
> this, requiring the user to use the native line as a GPIO. This of
> course assumes that all of the CS lines also have pinmux configurations
> as GPIO pins. Is this not a good assumption? 

As a general principle I would say no since it would mean adding a 2nd
GPIO device will potentially break the first if the infrastructure
isn't in place to handle the first line as a gpio.

g.

