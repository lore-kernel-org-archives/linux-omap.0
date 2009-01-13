From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH 2/2] OMAP: HSMMC: Fix response type for busy after
 response
Date: Tue, 13 Jan 2009 14:49:52 +0100
Message-ID: <20090113144952.3f8cbec8@mjolnir.drzeus.cx>
References: <20090113133827.29474.92645.sendpatchset@ahunter-laptop>
	<20090113133841.29474.15852.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761149AbZAMNxO@vger.kernel.org>
In-Reply-To: <20090113133841.29474.15852.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 13 Jan 2009 15:38:41 +0200
Adrian Hunter <ext-adrian.hunter@nokia.com> wrote:

> This also fixes the hidden problem that the controller
> was turning off the clock to the card while the card
> was busy - the clock was then switched on for the
> duration of each Send Status command used for polling,
> which is why writes did not lock up altogether.
> i.e. really dysfunctional.

Does the driver only keep the clock running as long as there is an
ongoing request? That kind of policy should really be handled in the
core where we have more information and can control it better. E.g. some
cards need the clock to finish up internal housekeeping so we need to
delay things for those.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
