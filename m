From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Tue, 16 Aug 2016 22:05:50 +0200
Message-ID: <20160816200550.GA7196@amd>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <0528B894-39CB-4D18-971E-3209EEEA2583@holtmann.org>
 <20160816090952.ur35t5bbcr7hsxvj@earth>
 <2B099E26-62C8-4778-B701-F727BB3FC110@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2B099E26-62C8-4778-B701-F727BB3FC110@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > I think we could use the packets from the firmware instead
> > of doing it manually (On N900 they are bit identical to the
> > manually generated one - On N950 I have not yet checked), but
> > until N900 works having it coded explicitly helps debugging.
> 
> We can also always manually encode the firmware to do it correctly. At the end of the day, the firmware should go into linux-firmware tree anyway.
> 

Editing firmware may raise some "interesting" legal questions... and
its redistribution might be tricky, too. Microsoft is not likely to be
too helpful :-(.

Best,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
