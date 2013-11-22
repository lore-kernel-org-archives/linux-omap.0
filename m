From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Allow MUSB DSPS to use "force host" mode
Date: Fri, 22 Nov 2013 17:33:05 +0100
Message-ID: <528F8741.1060406@linutronix.de>
References: <528F7E8F.5050807@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <528F7E8F.5050807@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, jkosina@suse.cz, anatol.pomozov@gmail.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Bin Liu <binmlist@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 11/22/2013 04:55 PM, Mark Jackson wrote:
> The IDDIG input pin is normally used to determine the USB mode
> (i.e. HOST or DEVICE).
> 
> On some systems (e.g. AM335x) leaving this pin floating allows
> the USB mode to be set via software.

So you have a board where musb is used only as host or only as device
and the ID pin not on ground or 3.3V?
What are the side effects? I remember correctly Bin wanted to avoid
settings this if it could be avoided.

Sebastian
