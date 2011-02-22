From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Booting n8x0 on mainline without UART
Date: Tue, 22 Feb 2011 08:41:46 +0200
Message-ID: <20110222084146.3a3e3cd4.jhnikula@gmail.com>
References: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59849 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1BVGk6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 01:40:58 -0500
Received: by eyx24 with SMTP id 24so561946eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 22:40:56 -0800 (PST)
In-Reply-To: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 22 Feb 2011 10:41:16 +0530
Anand Gadiyar <gadiyar@ti.com> wrote:

> Hi all,
> 
> I'm trying to boot up the mainline kernel on an n800 device. I don't have
> a functional UART up and running - so I cannot see any console messages.
> 
FYI, DIY console:
http://bu3sch.de/joomla/index.php/nokia-n810-serial-console

> Does anyone have instructions or pointers to any patches that may be
> needed to get the mainline linux kernel booting to the UI on this
> platform?
> 
Retu watchdog driver is needed since otherwise the retu will kick after
30 s or so. Those cbus/retu drivers are not in mainline (yet) but
hopefully they will thanks to Felipe Balbi.

> Alternatively, is there a way to direct the boot logs to the LCD instead
> of the UART/ttyMTD?
> 
It used to work but I think fb was broken a few months ago and I
haven't checked is working now. Unfortunately I don't have my N810
nearby so cannot do quick test now.

-- 
Jarkko
