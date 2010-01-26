From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 15:24:49 +0100
Message-ID: <201001261524.49661.oliver@neukum.org>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <201001260535.21689.david-b@pacbell.net> <20100126141443.GE10690@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754338Ab0AZOYf@vger.kernel.org>
In-Reply-To: <20100126141443.GE10690@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

Am Dienstag, 26. Januar 2010 15:14:43 schrieb Felipe Balbi:
> >There are load bursting issues too.  All part of the USB spec;
> >a load that's OK for 1 millisecond might not be OK for 1 second.
> 
> if you get a SetConfiguration(config), then you can use that load for as 
> long as needed, the limitation is when not enumerated, afaict.

And when suspended.

	HTH
		Oliver
