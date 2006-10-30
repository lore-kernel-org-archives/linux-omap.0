From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 3/6] [RFC] Add MMC Password Protection (lock/unlock) support V5
Date: Sun, 29 Oct 2006 19:06:50 -0700
Message-ID: <200610291806.56131.david-b@pacbell.net>
References: <20061020164914.012378000@localhost.localdomain> <20061020165135.162482000@localhost.localdomain> <45447914.7070101@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030454AbWJ3DHK@vger.kernel.org>
In-Reply-To: <45447914.7070101@drzeus.cx>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>, linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com, Tony Lindgren <tony@atomide.com>, Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

On Sunday 29 October 2006 1:49 am, Pierre Ossman wrote:

> > +	data_buf = kmalloc(data_size, GFP_KERNEL);
> >   
> 
> For something that can be at most 34 bytes, a kmalloc seems excessive.
> Put it on the stack. Just remember to have checks so we do not overflow.

It does seem excessive, but stack-allocated buffers are not guaranteed
to be DMA-safe.  See Documentation/DMA-mapping.txt right in the first
major section "What memory is DMA'able?"...
