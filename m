From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: [PATCH] [472/2many] MAINTAINERS - TI OMAP MMC INTERFACE DRIVER
Date: Mon, 13 Aug 2007 21:10:56 +0530
Message-ID: <a781481a0708130840w688e7a2eua7d7b5ec89bc5ad4@mail.gmail.com>
References: <46bffc14.hGERPpPFcYe9DKoT%joe@perches.com>
	 <20070813121807.26014455@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966436AbXHMQgX@vger.kernel.org>
In-Reply-To: <20070813121807.26014455@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: joe@perches.com, torvalds@linux-foundation.org, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On 8/13/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sun, 12 Aug 2007 23:37:08 -0700
> joe@perches.com wrote:
>
> > Add file pattern to MAINTAINER entry
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index af16a17..7a7f837 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4478,7 +4478,7 @@ F:      drivers/misc/tifm*
> >  F:   drivers/mmc/host/tifm_sd.c
> >
> >  TI OMAP MMC INTERFACE DRIVER
> > -P:   Carlos Aguiar, Anderson Briglia and Syed Khasim
> > +P:   Carlos Aguiar - Anderson Briglia - Syed Khasim
>
> NAK, Please stop sneaking other irrelevant changes into the patchset

Joe, it's okay to have multiple "P:" entries for the same driver/subsystem
in MAINTAINERS (grep BLACKFIN ARCHITECTURE for an extreme example :-)
So you could probably do something like that here as well (but continue
to have a single "M:" entry), though as Alan mentions it isn't really good
to make different kind of changes in the same patch.

BTW bad, sad, things happened to my mailbox while I was away :-(

Satyam
