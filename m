From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 07:16:49 -0800
Message-ID: <201001260716.49553.david-b@pacbell.net>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <201001261524.49661.oliver@neukum.org> <20100126143005.GI10690@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754510Ab0AZPQx@vger.kernel.org>
In-Reply-To: <20100126143005.GI10690@nokia.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Oliver Neukum <oliver@neukum.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 January 2010, Felipe Balbi wrote:
> but when suspended, we have to cut power ASAP. If not enumerated we can 
> still draw power for a few miliseconds due to dead battery provision.

When suspended, it's OK to draw a small amount of power.
On the order of one milliamp, based on the config that's
active ... instead of, often, hundreds.

That limit is why for example a PXA 255 could never get
certified as a bus-powered peripheral.  It required much
more than that when in suspend mode.
