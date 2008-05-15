From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RESENDING PATCH 0/4] Support for omap3430 LDP (zoom)
Date: Thu, 15 May 2008 07:42:01 -0700
Message-ID: <5e088bd90805150742n585bf232t341e5a52bb683cfa@mail.gmail.com>
References: <1210861832-10048-1-git-send-email-nskamat@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:29964 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbYEOOmC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 10:42:02 -0400
Received: by fk-out-0910.google.com with SMTP id 18so333016fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 07:42:01 -0700 (PDT)
In-Reply-To: <1210861832-10048-1-git-send-email-nskamat@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishant Kamat <nskamat@ti.com>
Cc: linux-omap@vger.kernel.org

Nishant,

It's not clear what order the patches should be applied.

I assume:

1. twl4030 defines
2. basic board support
3. ethernet support
4. default kernel config

Correct?

Steve


On Thu, May 15, 2008 at 7:30 AM, Nishant Kamat <nskamat@ti.com> wrote:
>
>  Tony, All,
>
>  > -----Original Message-----
>  > From: Kamat, Nishant
>  > Sent: Friday, May 02, 2008 4:57 PM
>  > To: linux-omap@vger.kernel.org
>  > Subject: [PATCH 0/7] Support for OMAP3430 LDP (Zoom)
>  >
>  >
>  > Tony, All,
>  >
>  > Following is a series of patches that add basic support for OMAP3430
>  > LDP, also known as the Zoom development kit. Refer [1] for more info.
>
>  I am resending the patches with the following changes:
>         - added MUSB as suggested by Filipe
>         - split out twl4030.h additions in a separate patch, as
>           suggested by Tony.
>         - removed the drivers/net/smc911x.[ch] changes from the series,
>           as suggested by Tony. I submitted them separately to linux-netdev.
>         - removed NAND driver changes from the series for now as more
>           changes are required.
>
>  Thanks,
>  Nishant
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
