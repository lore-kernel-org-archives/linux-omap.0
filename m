From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH v2] omap: i2c: don't check bus state IP rev3.3 and earlier
Date: Tue, 25 Nov 2014 17:38:23 +0300
Message-ID: <7E0A0B24-91D5-41A4-B007-004C5965D0D7@gmail.com>
References: <20141124210809.GG2817@atomide.com> <1416867655-22232-1-git-send-email-al.kochet@gmail.com> <20141125141924.GD1843@katana>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141125141924.GD1843@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org


25 =CE=CF=D1=C2. 2014 =C7., =D7 17:19, Wolfram Sang <wsa@the-dreams.de>=
 =CE=C1=D0=C9=D3=C1=CC(=C1):

> I'll push out this evening to make the boot tests work again. If ther=
e
> is more to be investigated, either hurry up and post v3 ;) or let me
> know that you need more time.

Ok, thank you. Let the fix go to the kernel-next.
Maybe small fix to subject "omap: i2c:" to "i2c: omap:"

I still guessing what some boards have broken i2c pull-ups.
And real fix must go in the board file.
http://www.spinics.net/lists/linux-i2c/msg17750.html

I could create a patch to confirm this.
But I don't have omap3530 boards to run.
I'll be very appreciated if someone could run the patch.

Regards,
Alexander.
