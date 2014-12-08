From: Pavel Machek <pavel@ucw.cz>
Subject: nokia_h4p on 3.16+
Date: Mon, 8 Dec 2014 21:47:35 +0100
Message-ID: <20141208204735.GA21599@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
Cc: balbi@ti.com, Greg KH <greg@kroah.com>, marcel@holtmann.org
List-Id: linux-omap@vger.kernel.org

Hi!

It seems commit:

commit bd5dc09f557547399cd44d0a1224df7ff64e4a6b
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Apr 23 09:58:28 2014 -0500

    serial: fix UART_IIR_ID

    UART IRQ Identification bitfield is 3
        bits long (bits 3:1) but current mask only
	    masks 2 bits. Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

breaks bluetooth driver on n900. (drivers/staging/nokia_h4p).

Pali, you may want to revert the patch.

That is good news, because reverting it on 3.18-rcX brings h4p back,
too (and as machine boots on nfsroot, debugging should be possible.)

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
