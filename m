From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Keymap fix for palmte and palmz71.
Date: Fri, 28 Mar 2008 13:43:33 +0200
Message-ID: <20080328114333.GC24896@atomide.com>
References: <1206630582-12074-1-git-send-email-edubezval@gmail.com> <fb249edb0803271048y288b4d61jb95347a9ab5ac87b@mail.gmail.com> <a0580c510803271213q48bcbbebjd346cd44b842d057@mail.gmail.com> <20080328104225.GZ24896@atomide.com> <fb249edb0803280439w6395b200jba455a40ebba69a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59632 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499AbYC1Lnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 07:43:37 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0803280439w6395b200jba455a40ebba69a5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

* andrzej zaborowski <balrogg@gmail.com> [080328 13:40]:
> On 28/03/2008, Tony Lindgren <tony@atomide.com> wrote:
> > * Eduardo Valentin <edubezval@gmail.com> [080327 21:16]:
> >  > It may  disappeared in a merge. However, this patch was based on:
> >  > http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011225.html
> >  >
> >  > That's why I thought the remotion was intended.
> >
> >
> > Andrzej, can you please check this? If patching for the input.h is
> >  needed, we should get it merged via LKML.
> 
> I think Eduardo's fix is the way to go regardless of what happened
> with KEY_CENTER.  I was only wondering why there was this change in
> input.h and why it wouldn't appear in gitweb.  I didn't realise that
> that key code was local to omap tree.

Thanks, will push Eduardo's patch today.

Tony
