From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/8] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output
 for DTS
Date: Fri, 27 Feb 2015 17:23:40 +0300
Message-ID: <54F07DEC.8000802@cogentembedded.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424961956-29353-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<54EF366A.2050108@cogentembedded.com> <CAMdRc4GO=FyELKkPgkL5W77MBh+CHWJ7GbEJdWU2LONLMrLTCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:41853 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbbB0OXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 09:23:44 -0500
Received: by labgd6 with SMTP id gd6so17857495lab.8
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2015 06:23:42 -0800 (PST)
In-Reply-To: <CAMdRc4GO=FyELKkPgkL5W77MBh+CHWJ7GbEJdWU2LONLMrLTCA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Cc: balbi@ti.com, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk

Hello.

On 2/27/2015 5:17 PM, Robert Abel wrote:

>>     Documentation/kernel-doc-nano-HOWTO.txt requires colons after the
>> parameter names, doesn't it?

> Jesus Christ, you guys are killing me...
> I've already spent way more time on this patch series than I intended
> to anyway...

    That's what you get when pushing your stuff upstream. You're not alone 
here. :-)

>>> +       mask = (1 << nr_bits) - 1;

>>     BIT(nr_bits) - 1, perhaps?

> Not happening... BIT macro obscures what's actually going on.

    I did search for a macro that does ((1 << n) - 1) but didn't found it, 
unfortunately...

> Regards,
> Robert

WBR, Sergei

