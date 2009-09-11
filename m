From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: FW: [RFC][PATCH]: Adding support for omap-serail driver
Date: Fri, 11 Sep 2009 11:45:02 +0530
Message-ID: <d6a0f7aa0909102315r3ec682a3u9b3da26eb031ca27@mail.gmail.com>
References: <F12CE1A68F023D498A2691C7B539311503935BC4@ZMY16EXM66.ds.mot.com>
	 <87ws46aj2a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:32380 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbZIKGO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 02:14:59 -0400
Received: by qw-out-2122.google.com with SMTP id 9so287362qwb.37
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 23:15:02 -0700 (PDT)
In-Reply-To: <87ws46aj2a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: HU TAO-TGHK48 <taohu@motorola.com>, linux-omap@vger.kernel.org

Hi,

>
> FWIW, as the author of much of the PM hacker in mach-omap2/serial.c, I
> agree with Tao.
>
> The only reason for the PM hackery in mach-omap2/serial.c is because
> of the limitations of the 8250 driver.
>

I have an query,

We have following functionality in serial.c:
1.) Enabling and disabling uart clocks.
2.) Adding rx wakeup capabilities.
3.) Preparing UARTs for idle mode.
4.) Context save and restore.

What functionality should be retained in serial.c file?

AFAIK currently no serial driver has incorporated their platform
specific PM functionality like context_save and restore into their
serial driver, shouldn't these things be retained into
*/mach-omap2/serial.c ?

---
Regards,
Govindraj.R
