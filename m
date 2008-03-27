From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] Keymap fix for palmte and palmz71.
Date: Thu, 27 Mar 2008 18:48:30 +0100
Message-ID: <fb249edb0803271048y288b4d61jb95347a9ab5ac87b@mail.gmail.com>
References: <1206630582-12074-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:21421 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbYC0Rsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:48:30 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3790309wff.4
        for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 10:48:30 -0700 (PDT)
In-Reply-To: <1206630582-12074-1-git-send-email-edubezval@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi,

On 27/03/2008, Eduardo Valentin <edubezval@gmail.com> wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>
>  Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  ---
>   arch/arm/mach-omap1/board-palmte.c  |    2 +-
>   arch/arm/mach-omap1/board-palmz71.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
>  diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
>  index 63c3131..f4860b0 100644
>  --- a/arch/arm/mach-omap1/board-palmte.c
>  +++ b/arch/arm/mach-omap1/board-palmte.c
>  @@ -64,7 +64,7 @@ static const int palmte_keymap[] = {
>         KEY(1, 1, KEY_DOWN),
>         KEY(1, 2, KEY_UP),
>         KEY(1, 3, KEY_RIGHT),
>  -       KEY(1, 4, KEY_CENTER),
>  +       KEY(1, 4, KEY_ENTER),

I'm not sure if the disappearance of KEY_CENTER in
include/linux/input.h was intended or accidental. I can't find the
exact commitdiff that removed it, in either gitweb or gitview. It can
be seen in gitweb that the tree in this commit still has it (after a
bit merge) http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=dd1d9a62f7cd60b544013eb429d6a3137617f0b2
and the following commit:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=5517853712f1f6daac8a7b2590f9b821e767aa13
has no KEY_CENTER. Is that a merge conflict?
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
