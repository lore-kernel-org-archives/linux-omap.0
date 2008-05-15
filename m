From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 2/3] N810: Don't export camera orientation
Date: Thu, 15 May 2008 08:54:34 +0200
Message-ID: <fb249edb0805142354o2060cf43xd98e6d3e64806a74@mail.gmail.com>
References: <12106946631016-git-send-email-sakari.ailus@nokia.com>
	 <1210694663310-git-send-email-sakari.ailus@nokia.com>
	 <20147cff763adbdb887ad31373040efc@felipebalbi.com>
	 <482AD555.40905@nokia.com>
	 <20080514225823.GF1582@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:42124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYEOGyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 02:54:36 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1313485ugf.16
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2008 23:54:34 -0700 (PDT)
In-Reply-To: <20080514225823.GF1582@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org

On 15/05/2008, Felipe Balbi <me@felipebalbi.com> wrote:
> On Wed, May 14, 2008 at 03:04:37PM +0300, Sakari Ailus wrote:
>  > ext Felipe Balbi wrote:
>  >
>  > Hello Felipe, and thanks for reviewing the patch! :)
>  >
>  >> On Tue, 13 May 2008 19:04:22 +0300, Sakari Ailus <sakari.ailus@nokia.com>
>  >> wrote:
>  >>> @@ -298,12 +340,21 @@ static int tcm825x_ifparm(struct v4l2_ifparm *p)
>  >>>     return 0;
>  >>>  }
>  >>>
>  >>> +static int tcm825x_is_upside_down(void)
>  >>> +{
>  >>> +   if (machine_is_nokia_n810())
>  >>> +           return 1;
>  >>> +
>  >>> +   return 0;
>  >>> +}
>  >>> +
>  >>>  const struct tcm825x_platform_data n800_tcm825x_platform_data = {
>  >>> -   .is_okay      = tcm825x_is_okay,
>  >>> -   .power_set    = tcm825x_power_set,
>  >>> -   .default_regs = tcm825x_default_regs,
>  >>> -   .needs_reset  = tcm825x_needs_reset,
>  >>> -   .ifparm       = tcm825x_ifparm,
>  >>> +   .is_okay        = tcm825x_is_okay,
>  >>> +   .power_set      = tcm825x_power_set,
>  >>> +   .default_regs   = tcm825x_default_regs,
>  >>> +   .needs_reset    = tcm825x_needs_reset,
>  >>> +   .ifparm         = tcm825x_ifparm,
>  >>> +   .is_upside_down = tcm825x_is_upside_down,
>  >>
>  >> ok, now i got your point but this could be:
>  >> .is_upside_down = machine_is_nokia_n810() ? 1 : 0,
>  >
>  > This doesn't work because machine_is_nokia_n810() is not constant.
>  >
>  > Anyway, tcm825x_is_upside_down can be made more simple as it could just
>  > return machine_is_nokia_n810().
>  >
>  > I'll send new patches.
>
>  Didn't quite get, machine_is_nokia_n810() will always be true when
>  running in n810. Could you clarify a bit :-p

It'll *return* true, but C initialisers must be constants.  It simply
wouldn't compile.

Cheers
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
