From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Mon, 14 Mar 2011 22:06:40 -0400
Message-ID: <87ipvlm91r.fsf@gmail.com>
References: <87ipvmx2ok.fsf@gmail.com> <1300043119-11262-1-git-send-email-bgamari.foss@gmail.com> <20110314192718.GG16096@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57884 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab1COCGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 22:06:47 -0400
Received: by vws1 with SMTP id 1so156516vws.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 19:06:46 -0700 (PDT)
In-Reply-To: <20110314192718.GG16096@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org

On Mon, 14 Mar 2011 13:27:18 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> What if the board wanted to use both the native SPI ss line as well as
> one or more GPIOs?  You probably want to reserve cs0 for the native
> gpio line.
> 
Hmm, I had thought about this and assumed it would be easiest to punt on
this, requiring the user to use the native line as a GPIO. This of
course assumes that all of the CS lines also have pinmux configurations
as GPIO pins. Is this not a good assumption? 

> Otherwise this patch looks good to me.
> 
Thanks!

- Ben

