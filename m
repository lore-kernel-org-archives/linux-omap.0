From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Date: Sat, 18 Nov 2006 14:18:09 -0800
Message-ID: <200611181418.10675.david-b@pacbell.net>
References: <455DB1FB.1060403@indt.org.br> <200611181117.54242.david-b@pacbell.net> <455F7E2A.60009@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753872AbWKRWSQ@vger.kernel.org>
In-Reply-To: <455F7E2A.60009@drzeus.cx>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Anderson Briglia <anderson.briglia@indt.org.br>, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

On Saturday 18 November 2006 1:42 pm, Pierre Ossman wrote:
> David Brownell wrote:
> > I thought the MMC vendors expected to see the actual user-typed
> > password get SHA1-hashed into a value which would take up the whole
> > buffer?  In general that's a good idea, since it promotes use of
> > longer passphrases (more information) over short ones (easy2crack).
> >   
> 
> This sounds like policy though, so it is something user space should
> concern itself with. We should just provide the infrastructure.

The kernel shouldn't hash, right.  But the userspace toos
probably should be doing that ... they're the other part of
the infrastructure. :)

- Dave
