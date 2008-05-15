From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 2/2] Input: Make lm8323 sticky key to work with console
Date: Thu, 15 May 2008 10:14:24 +0200
Message-ID: <fb249edb0805150114vdcf2a7crbd498f36613c7bc@mail.gmail.com>
References: <1210824079-22548-1-git-send-email-tony@atomide.com>
	 <1210824079-22548-2-git-send-email-tony@atomide.com>
	 <1210824079-22548-3-git-send-email-tony@atomide.com>
	 <20080515080333.GD4625@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:13084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbYEOIO0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 04:14:26 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1325623ugf.16
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 01:14:25 -0700 (PDT)
In-Reply-To: <20080515080333.GD4625@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, daniel.stone@nokia.com

On 15/05/2008, Felipe Balbi <me@felipebalbi.com> wrote:
> On Wed, May 14, 2008 at 09:01:19PM -0700, Tony Lindgren wrote:
>  > This allows using N810 keyboard from console by adding optional
>  > Fn and shift sticky key handling by passing them from platform_data.
>  >
>  > Currently some not so obvious mappings are:
>  >
>  > - Pipe is Fn + Enter
>  > - Delete is Fn + Backspace
>  > - Escape is Fn + Ctrl
>
>  no tab? :-(
>
>  Fn + space maybe?? :-p

Fn + Right is assigned in the patch (I check too :) ).  But I'm not
sure whther that should be done in the lm8323 driver or elsewhere. The
existence of keys like Fn and Shift is N810-specific and lm8323 is
just a gpio matrix keypad chip.

Regards
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
