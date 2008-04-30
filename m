From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 4/7] OMAP3 EVM: add onenand flash support
Date: Wed, 30 Apr 2008 06:08:06 -0700
Message-ID: <5e088bd90804300608p4b57e07bxcb0c317d036cbc8e@mail.gmail.com>
References: <5e088bd90804281629n5bb4eb0cu3eb1704e521548cf@mail.gmail.com>
	 <0841370d1474c97fc74cfad2116790aa@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:20055 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710AbYD3NIJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 09:08:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so151074fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 30 Apr 2008 06:08:06 -0700 (PDT)
In-Reply-To: <0841370d1474c97fc74cfad2116790aa@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

On Wed, Apr 30, 2008 at 1:35 AM, Felipe Balbi <me@felipebalbi.com> wrote:

>  > +             .name           = "xloader",
>  > +             .offset         = 0,
>  > +             .size           = 4*(64*2048),
>
>  should be .size = SZ_512k,

OK, will do.

>  > +             .name           = "uboot",
>  > +             .offset         = MTDPART_OFS_APPEND,
>  > +             .size           =  15*(64*2048),
>
>  most of the boards use .size = SZ_128K here

This seemed strange to me too, but this is the way the board ships so
I was hesitant to change it.  A change here will require changes to
u-boot reflash scripts, etc.  Might cause a bit of confusion!  What do
others think?

>  > +             .name           = "params",
>  > +             .offset         = MTDPART_OFS_APPEND,
>  > +             .size           = 1*(64*2048),
>
>  SZ_128K

OK, will do.

>  > +             .name           = "linux",
>  > +             .offset         = MTDPART_OFS_APPEND,
>  > +             .size           = 40*(64*2048),
>
>  This looks too big for kernel only.
>  SZ_4M is way enough.

Same comment as above.  I am hesitant to change this without more
discussion here.  But I agree that it makes sense :-)

Thanks!

Steve
