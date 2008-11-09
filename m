From: "Ramesh Gupta Guntha" <grgupta77@gmail.com>
Subject: Re: BRIDGE: DSP-DMA copy failure
Date: Sun, 9 Nov 2008 08:53:56 +0530
Message-ID: <3a2dabf50811081923s70a54bf7j228e16fcdea05b44@mail.gmail.com>
References: <BC7FE67E-F469-4D08-A3DF-F8EF66709E73@maeth.com>
	 <20081108.213602.68814136.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:57162 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbYKIDX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Nov 2008 22:23:57 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2111298muf.1
        for <linux-omap@vger.kernel.org>; Sat, 08 Nov 2008 19:23:56 -0800 (PST)
In-Reply-To: <20081108.213602.68814136.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: wiking@maeth.com, vpasam@ti.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x00omar@ti.com

Hi Hiroshi,

On 11/9/08, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hi Viktor,
>
> According to the error code#, "0x8000803a", it implies "Invalid stream
> mode" and it seems that currently only "STRMMODE_PROCCOPY" is
> supported as below?
>
> linux/drivers/dsp/bridge/rmgr/node.c:NODE_Connect():
> .....
>        /*
>         * Check stream mode. Default is STRMMODE_PROCCOPY.
>         */
>        if (DSP_SUCCEEDED(status) && pAttrs) {
>                if (pAttrs->lMode != STRMMODE_PROCCOPY)
>                        status = DSP_ESTRMMODE; /* illegal stream mode */
>
>        }
> .....
>
> So "strmcopy.out 1" and  "strmcopy.out 2" don't seem to work at
> present?
>
> Vijay, do you have any idea on the above, how to enable the other
> STRMMODE_*?


Currently bridge supports only PROCCOPY mode for Streams, other modes
are deprecated. The sample application options need to be cleaned up.
-- 
Thanks
Ramesh Gupta G
