From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bluetooth: Add hci_h4p driver
Date: Sun, 14 Dec 2014 10:47:57 +0100
Message-ID: <20141214094757.GA28973@amd>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
 <20141213235131.GA23566@amd>
 <ED6FB9B5-7BD5-4398-ACA4-C5D1547B91A4@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ED6FB9B5-7BD5-4398-ACA4-C5D1547B91A4@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@debian.org>, Sebastian Reichel <sre@ring0.de>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-bluetooth@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2014-12-14 01:07:42, Marcel Holtmann wrote:
> Hi Pavel,
> 
> >>> My notes say that Marcel wanted different filenames, but I'd need
> >>> advice exactly what filenames. I guess platform data supprort should
> >>> be removed altogether, rather than renamed.
> >> 
> >> Yes, the platform support should go away. This should be purely based on DT.
> >> 
> >> Can you also start using git format-patch so that patches get a diffstat.
> > 
> > So the rest of filenames look ok?
> 
> I have not looked at the patch or the filenames at all.

Ok, so here's diffstat. Can you take a look?

Thanks,
									Pavel

 drivers/bluetooth/Kconfig                  |   10 
 drivers/bluetooth/Makefile                 |    3 
 drivers/bluetooth/hci_h4p.h                |  234 +++++
 drivers/bluetooth/nokia_core.c             | 1262 +++++++++++++++++++++++++++++
 drivers/bluetooth/nokia_fw-bcm.c           |   27 
 drivers/bluetooth/nokia_fw.c               |  105 ++
 drivers/bluetooth/nokia_uart.c             |  179 ++++
 include/linux/platform_data/bt-nokia-h4p.h |    4 
 8 files changed, 1822 insertions(+), 2 deletions(-)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
