From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: about n810 integration status
Date: Thu, 30 Jun 2011 08:17:03 +0300
Message-ID: <20110630051703.GG12671@valkosipuli.localdomain>
References: <42DA59FF-FC09-437C-9C0E-85AE527B3606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-68.nebula.fi ([83.145.220.68]:36584 "EHLO
	smtp-68.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab1F3FYw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 01:24:52 -0400
Content-Disposition: inline
In-Reply-To: <42DA59FF-FC09-437C-9C0E-85AE527B3606@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim HeungJun <riverful@gmail.com>
Cc: linux-omap@vger.kernel.org, dacohen@gmail.com, fbalbi@ti.com

On Sat, Jun 25, 2011 at 03:00:01PM +0900, Kim HeungJun wrote:
> Hi everyone,

Hi HeungJun,

> Does anybody knows about n810 integration status on Kernel? I have one
> n810, and I try to update the newest kernel and filesystem image freely.
> And, if anyone know about , please let me know.

Are you using your own root filesystem or the original Diablo one?

I've been using Debian without display so I just have had a serial console.
The display might be working as well --- I just haven't tried it since the
serial port is enough for me right now. :-P I can find my kernel .config if
you're interested. NFS over USB works fine.

Just grab latest linux-omap kernel. I don't think all the required CBUS
changes are in mainline quite yet, but they're on their way there.

> The information which I know is just the flasher from Nokia is needed for
> updating. And, I can compile kernel and handle a litte.

Flashing instructions are available here:

<URL:http://wiki.maemo.org/index.php?title=Updating_the_firmware&oldid=17120>

It's the same flasher as on N900.

Regards,

-- 
Sakari Ailus
sakari.ailus@iki.fi
