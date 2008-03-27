From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH] Keymap fix for palmte and palmz71.
Date: Thu, 27 Mar 2008 15:13:58 -0400
Message-ID: <a0580c510803271213q48bcbbebjd346cd44b842d057@mail.gmail.com>
References: <1206630582-12074-1-git-send-email-edubezval@gmail.com>
	 <fb249edb0803271048y288b4d61jb95347a9ab5ac87b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:30160 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739AbYC0TN6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 15:13:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4959153wah.23
        for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 12:13:58 -0700 (PDT)
In-Reply-To: <fb249edb0803271048y288b4d61jb95347a9ab5ac87b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi andrzej,

It may  disappeared in a merge. However, this patch was based on:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011225.html

That's why I thought the remotion was intended.


Cheers,


On Thu, Mar 27, 2008 at 1:48 PM, andrzej zaborowski <balrogg@gmail.com> wrote:
> Hi,
>
>
>  On 27/03/2008, Eduardo Valentin <edubezval@gmail.com> wrote:
>  > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  >
>  >  Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  >  ---
>  >   arch/arm/mach-omap1/board-palmte.c  |    2 +-
>  >   arch/arm/mach-omap1/board-palmz71.c |    2 +-
>  >   2 files changed, 2 insertions(+), 2 deletions(-)
>  >
>  >  diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
>  >  index 63c3131..f4860b0 100644
>  >  --- a/arch/arm/mach-omap1/board-palmte.c
>  >  +++ b/arch/arm/mach-omap1/board-palmte.c
>  >  @@ -64,7 +64,7 @@ static const int palmte_keymap[] = {
>  >         KEY(1, 1, KEY_DOWN),
>  >         KEY(1, 2, KEY_UP),
>  >         KEY(1, 3, KEY_RIGHT),
>  >  -       KEY(1, 4, KEY_CENTER),
>  >  +       KEY(1, 4, KEY_ENTER),
>
>  I'm not sure if the disappearance of KEY_CENTER in
>  include/linux/input.h was intended or accidental. I can't find the
>  exact commitdiff that removed it, in either gitweb or gitview. It can
>  be seen in gitweb that the tree in this commit still has it (after a
>  bit merge) http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=dd1d9a62f7cd60b544013eb429d6a3137617f0b2
>  and the following commit:
>  http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=5517853712f1f6daac8a7b2590f9b821e767aa13
>  has no KEY_CENTER. Is that a merge conflict?
>  --
>  Please do not print this email unless absolutely necessary. Spread
>  environmental awareness.
>



-- 
Eduardo Bezerra Valentin
