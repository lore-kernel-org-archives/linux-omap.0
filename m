From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 2/5] usb: otg: twl4030: add support for notifier
Date: Sat, 12 Dec 2009 18:34:10 +0000
Message-ID: <20091212183410.GF3092@sirena.org.uk>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <1260531086-23857-3-git-send-email-felipe.balbi@nokia.com>
 <c60a9cb0912110922g10fd0cc7m3b3430731db5ed81@mail.gmail.com>
 <20091211204014.GA30776@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934437AbZLMBuw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091211204014.GA30776@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext sai pavan <saipavan.243@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 11, 2009 at 10:40:14PM +0200, Felipe Balbi wrote:

> that's a threaded irq. Maybe we should patch all twl children to use
> request_threaded_irq() already. I'll test that tomorrow.

You should also now be able to do all the interrupt handling with genirq
without the lockdep dodges that used to be be required.
