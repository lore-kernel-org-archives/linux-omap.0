From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] Stop AIC23 driver from Oopsing.
Date: Fri, 4 Apr 2008 01:54:42 +0200
Message-ID: <fb249edb0804031654l619366abub53ca1692e1b2aa5@mail.gmail.com>
References: <12068100513180-git-send-email-balrogg@gmail.com>
	 <20080402070913.GB31913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:3892 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYDCXyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 19:54:46 -0400
Received: by ug-out-1314.google.com with SMTP id z38so855135ugc.16
        for <linux-omap@vger.kernel.org>; Thu, 03 Apr 2008 16:54:43 -0700 (PDT)
In-Reply-To: <20080402070913.GB31913@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 02/04/2008, Tony Lindgren <tony@atomide.com> wrote:
> * Andrzej Zaborowski <balrogg@gmail.com> [080329 18:30]:
>
> > From: Andrzej Zaborowski <balrog@zabor.org>
>  >
>  > Prevent AIC23 driver Oopsing when no AIC23 is present by moving some of the
>  > initialisation to after the chip is found.  There seems to be more that
>  > should be fixed in this driver but with this change it can at least be
>  > compiled into a kernel safely.
>
>
> This does not seem to apply, can you please check?

Oops, I had forgotten to update. Now rebased and resent, with an
additional typo corrected in one of the error messages.
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
