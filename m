From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Ubuntu installation on omap
Date: Wed, 10 Feb 2010 08:44:16 -0600
Message-ID: <4551feaf1002100644h27efa26fqecd28009af59fc99@mail.gmail.com>
References: <4ad3b6301002090141j3a57c223ib50c254b656239fc@mail.gmail.com>
	 <4551feaf1002090707r1069f25esc2582245057f236@mail.gmail.com>
	 <4ad3b6301002092130x7ea28ed8l9be0cfefc265684d@mail.gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0C012EBD13D9@dlee02.ent.ti.com>
	 <4ad3b6301002100434n74910f7csf736b92f957f4555@mail.gmail.com>
	 <4ad3b6301002100435k301e79f3rf8213cf65fd37ff7@mail.gmail.com>
	 <4ad3b6301002100438l6fcd5e35qb50312199eca03d8@mail.gmail.com>
	 <4ad3b6301002100633u5e8edff9x89ee543cdd27d3bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:34952 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0BJOoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 09:44:20 -0500
Received: by ewy28 with SMTP id 28so66724ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 06:44:18 -0800 (PST)
In-Reply-To: <4ad3b6301002100633u5e8edff9x89ee543cdd27d3bc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Niamathullah sharief <omapsha@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 10, 2010 at 8:33 AM, Niamathullah sharief <omapsha@gmail.com> wrote:
> still i am getting my kernel booting
> i am using "bootcmd=mmcinit;fatload mmc 0:1 0x80000000 uImage;bootm
> 0x80000000". But i am creating uImage using "mkimage -A arm -O linux
> -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d
> ./vmlinuz-* ./uImage"
> is this ok?i think the problem might be here. Please help me

this is kinda offtopic for this list, you should really use:
http://groups.google.com/group/beagleboard

heads up: 'mmcinit' was depreciated in later uboot's as it's now 'mmc init'

For the beagle most use: 0x80300000 instead of 0x80000000  but it should boot..

Could you pastebin.com your complete boot log from the serial port, so
we could see what's actually going wrong?

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
