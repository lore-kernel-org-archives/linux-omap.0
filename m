From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-v2][RFC] OMAP4: Keypad Support for OMAP4430
Date: Fri, 28 Aug 2009 09:16:45 -0700
Message-ID: <20090828161645.GM25828@atomide.com>
References: <47940.192.168.10.88.1251196743.squirrel@dbdmail.itg.ti.com> <20090827065208.9B1C0526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090827065208.9B1C0526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Syed Rafiuddin <rafiuddin.syed@ti.com>, soni.trilok@gmail.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [090826 23:20]:
> On Tue, Aug 25, 2009 at 04:09:03PM +0530, Syed Rafiuddin wrote:
> > From: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > 
> > Resending with correct Subject.
> > 
> > This patch Adds Keypad support on OMAP4.And adds
> > OMAP4 register addresses and configures them for OMAP4.
> > 
> > 
> > This patch has been updated as per the comments received from
> > Trilok Soni to remove GPIO based omap2 keypad logic from omap_keypad.c
> > (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14570.html)
> > Matrix_keypad.c (gpio based keypad driver) can be used in OMAP2,
> > which is not tested on OMAP2 since unavailability of omap2 target's.
> > 
> 
> So has omap2 been switched over to matrix-keypad? Otherwise ripping
> omap2 support from omap-keypad is premature.

Hmm yeah that should be a separate patch that swithces 24xx to use
the GPIO keypad driver and removes the related logic from this patch.

Tony
