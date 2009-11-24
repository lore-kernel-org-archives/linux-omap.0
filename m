From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency constraint	in i2c
Date: Tue, 24 Nov 2009 07:54:22 -0800
Message-ID: <87pr77x6j5.fsf@deeprootsystems.com>
References: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-4-git-send-email-kalle.jokiniemi@digia.com>
	<CD8CC2B65FEE304DA95744A5472698F2029E427B04@dlee06.ent.ti.com>
	<1256644921.6751.61.camel@ubuntu>
	<CD8CC2B65FEE304DA95744A5472698F2029E75531B@dlee06.ent.ti.com>
	<E839BB5467CE1640B3CC2F90F647A52C274A095246@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:34943 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758101AbZKXPyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 10:54:19 -0500
Received: by pxi10 with SMTP id 10so5015153pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 07:54:25 -0800 (PST)
In-Reply-To: <E839BB5467CE1640B3CC2F90F647A52C274A095246@NOK-EUMSG-02.mgdnok.nokia.com> (kalle jokiniemi's message of "Tue\, 24 Nov 2009 16\:19\:00 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@nokia.com
Cc: m-sonasath@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com, paul@pwsan.com, nm@ti.com, vikram.pandita@ti.com, jouni.hogander@nokia.com

<kalle.jokiniemi@nokia.com> writes:

>> The patch V4 looks perfect to me :)
>
> Great :)
>
> So, where do we push it?

I suggest to Ben Dooks (i2c maintainer for embedded platforms) and to linux-i2c list.
Also Cc linux-omap.  


>From MAINTAINERS:

I2C SUBSYSTEM
M:	"Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
L:	linux-i2c@vger.kernel.org
W:	http://i2c.wiki.kernel.org/
T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
S:	Maintained
F:	Documentation/i2c/
F:	drivers/i2c/
F:	include/linux/i2c.h
F:	include/linux/i2c-dev.h
F:	include/linux/i2c-id.h


Also, FYI... in recent kernels there is a scripts/get_maintainer.pl
script.  If you run a patch through that script, it will spit out a
list of folks to send the patch to.

Kevin
