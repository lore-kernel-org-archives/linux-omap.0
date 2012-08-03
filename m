From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: convert to module_platform_driver"
Date: Fri, 03 Aug 2012 17:20:48 +0530
Message-ID: <501BBB18.5090201@ti.com>
References: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi> <CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com> <1343981127.2744.28.camel@deskari> <20120803094553.GA731@harshnoise.musicnaut.iki.fi> <20120803095836.GE6073@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:57827 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752746Ab2HCLuz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 07:50:55 -0400
Received: by yhmm54 with SMTP id m54so746992yhm.33
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 04:50:54 -0700 (PDT)
In-Reply-To: <20120803095836.GE6073@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Friday 03 August 2012 03:28 PM, Felipe Balbi wrote:
>> [    1.496124] spi spi1.0: setup mode 0, 8 bits/w, 6000000 Hz max --> 0
>> > [    1.503265] omap2_mcspi omap2_mcspi.1: registered child spi1.0
>> > 
>> > If I modify the board file so that child spi1.0 is registered before
>> > spi1.2, then it starts to work properly:
> that sounds quite odd... Shubhro, have you seen this before on any of
> our platforms ?
>
I havent seen this behaviour may be I didn't have this configuration.
Will try to see if I have any way of recreating and testing the multi cs
on one of our boards.

BTW I didnt understand why does that matter at all the cs order.

Aaro,
I am missing what is making the order matter.
What is it that I am missing?
