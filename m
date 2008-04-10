From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Thu, 10 Apr 2008 15:18:33 +0200
Message-ID: <fb249edb0804100618x61c3d47dwf9bca3ad8ee2dbc3@mail.gmail.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com>
	 <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com>
	 <20080409121124.GS7338@gandalf.research.nokia.com>
	 <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com>
	 <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38743 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163AbYDJNSf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 09:18:35 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1284333ugc.16
        for <linux-omap@vger.kernel.org>; Thu, 10 Apr 2008 06:18:34 -0700 (PDT)
In-Reply-To: <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Stone <daniel.stone@nokia.com>

On 09/04/2008, Felipe Balbi <me@felipebalbi.com> wrote:
> On Wed, Apr 09, 2008 at 07:26:31PM +0200, andrzej zaborowski wrote:
>  [...]
>
>  > >  +       time = strict_strtoul(buf, 10, &res);
>  > >  +       /* Numbers only, please. */
>  > >  +       if (buf && *buf != '\n' && *(buf + 1) != '\0')
>  > >  +               return -EINVAL;
>  >
>  > The condition doesn't look correct, for example it rejects "55\n\0"
>  > but accepts NULL.
>
>
> Well, this is not my driver and i just moved to strict_stroul cuz
>  checkpatch asked me to. I'll take a closer look tomorrow but if you can
>  come up with a better solution for this, I'll ack.

Turns out the result is returned in the buffer in third parameter, and
the checking is already "strict" (rejects trailing non-numbers), so
this should look something like:

ret = strict_strtoul(buf, 0, &time);
if (ret)
        return ret;

>
>  btw, good catch, i didn't had too much time to work on this but still
>  the driver is working fine.
>
>
>  > >  +       i2c_set_clientdata(client, lm);
>  > >  +       lm->client = client;
>  > >  +       lm8323_pdata = client->dev.platform_data;
>  > >  +       if (!lm8323_pdata)
>  > >  +               return -EINVAL; /* ? */
>  >
>  > Here lm remains allocated and is lost.  Not that it bothers me, but
>  > probably not what was intended.
>
>
> You mean the error handling?

Yep.

>
>  if (!lm8323_pdata) {
>         kfree(lm);
>         return -EINVAL;
>  }
>
>  fixing tomorrow.

Thanks
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
