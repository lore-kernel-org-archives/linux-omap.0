From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 10:22:26 -0500
Message-ID: <87y5h4r4ul.fsf@gmail.com>
References: <50C5E23D.5040605@communistcode.co.uk> <20121210135337.GA10219@arwen.pp.htv.fi> <50C5F6A8.5060701@communistcode.co.uk> <20121210145947.GK11038@arwen.pp.htv.fi> <50C5FD73.1000408@communistcode.co.uk> <20121210183500.GB14303@arwen.pp.htv.fi> <50C70846.7010207@communistcode.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62942 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab2LKPW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 10:22:29 -0500
Received: by mail-gh0-f174.google.com with SMTP id g15so751006ghb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Dec 2012 07:22:28 -0800 (PST)
In-Reply-To: <50C70846.7010207@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ml@communistcode.co.uk, balbi@ti.com
Cc: linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

Jack Mitchell <ml@communistcode.co.uk> writes:

> Shubhro, Felipe,
>
> Thank you, the reordering dma patch fixed the dma issue I was having! 
> However, the bad news, I now get the same results for the dma and 
> non-dma spidev test. While the scope shows the SPI clk and data is fine, 
> the reading from the program still shows 0x00 for all words.
>
Just to make sure this has been thought of: I've seen this sort of
behavior in the past when the CLK pin wasn't configured as an input.

Cheers,

- Ben

