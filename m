From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bluetooth: Add hci_h4p driver
Date: Sun, 14 Dec 2014 00:51:31 +0100
Message-ID: <20141213235131.GA23566@amd>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > My notes say that Marcel wanted different filenames, but I'd need
> > advice exactly what filenames. I guess platform data supprort should
> > be removed altogether, rather than renamed.
> 
> Yes, the platform support should go away. This should be purely based on DT.
> 
> Can you also start using git format-patch so that patches get a diffstat.

So the rest of filenames look ok?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
