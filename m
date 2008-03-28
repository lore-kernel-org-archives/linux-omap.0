From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Keymap fix for palmte and palmz71.
Date: Fri, 28 Mar 2008 12:42:26 +0200
Message-ID: <20080328104225.GZ24896@atomide.com>
References: <1206630582-12074-1-git-send-email-edubezval@gmail.com> <fb249edb0803271048y288b4d61jb95347a9ab5ac87b@mail.gmail.com> <a0580c510803271213q48bcbbebjd346cd44b842d057@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51407 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYC1Km2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:42:28 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510803271213q48bcbbebjd346cd44b842d057@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: andrzej zaborowski <balrogg@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Eduardo Valentin <edubezval@gmail.com> [080327 21:16]:
> Hi andrzej,
> 
> It may  disappeared in a merge. However, this patch was based on:
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011225.html
> 
> That's why I thought the remotion was intended.

Andrzej, can you please check this? If patching for the input.h is
needed, we should get it merged via LKML.

Tony

> 
> 
> Cheers,
> 
> 
> On Thu, Mar 27, 2008 at 1:48 PM, andrzej zaborowski <balrogg@gmail.com> wrote:
> > Hi,
> >
> >
> >  On 27/03/2008, Eduardo Valentin <edubezval@gmail.com> wrote:
> >  > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >  >
> >  >  Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >  >  ---
> >  >   arch/arm/mach-omap1/board-palmte.c  |    2 +-
> >  >   arch/arm/mach-omap1/board-palmz71.c |    2 +-
> >  >   2 files changed, 2 insertions(+), 2 deletions(-)
> >  >
> >  >  diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
> >  >  index 63c3131..f4860b0 100644
> >  >  --- a/arch/arm/mach-omap1/board-palmte.c
> >  >  +++ b/arch/arm/mach-omap1/board-palmte.c
> >  >  @@ -64,7 +64,7 @@ static const int palmte_keymap[] = {
> >  >         KEY(1, 1, KEY_DOWN),
> >  >         KEY(1, 2, KEY_UP),
> >  >         KEY(1, 3, KEY_RIGHT),
> >  >  -       KEY(1, 4, KEY_CENTER),
> >  >  +       KEY(1, 4, KEY_ENTER),
> >
> >  I'm not sure if the disappearance of KEY_CENTER in
> >  include/linux/input.h was intended or accidental. I can't find the
> >  exact commitdiff that removed it, in either gitweb or gitview. It can
> >  be seen in gitweb that the tree in this commit still has it (after a
> >  bit merge) http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=dd1d9a62f7cd60b544013eb429d6a3137617f0b2
> >  and the following commit:
> >  http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=5517853712f1f6daac8a7b2590f9b821e767aa13
> >  has no KEY_CENTER. Is that a merge conflict?
> >  --
> >  Please do not print this email unless absolutely necessary. Spread
> >  environmental awareness.
> >
> 
> 
> 
> -- 
> Eduardo Bezerra Valentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
