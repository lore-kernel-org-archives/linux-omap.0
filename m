From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info
 reordering
Date: Fri, 01 Apr 2011 13:54:22 +0300
Message-ID: <1301655262.1988.477.camel@cumari>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
	 <AANLkTikPawWg8Wt8F4oeEBbvUOziPNrH+7A3MyXkx8Lw@mail.gmail.com>
	 <1301646040.1988.421.camel@cumari>
	 <AANLkTin3hLZEKOJ6bWN6sk_1G6eQyvX+ovAKT2XviC4u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57355 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268Ab1DAKxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:53:46 -0400
Received: by mail-wy0-f180.google.com with SMTP id 26so4015515wyj.11
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 03:53:45 -0700 (PDT)
In-Reply-To: <AANLkTin3hLZEKOJ6bWN6sk_1G6eQyvX+ovAKT2XviC4u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, 2011-04-01 at 15:56 +0530, Kishore Kadiyala wrote:
> > As I said, I don't know much about the OMAP MMC subsystem and I
> don't
> > have the time right now to investigate what really is wrong.  That's
> why
> > I sent this patch, as quick fix (or rather getting rid of a
> regression).
> 
> I don't see any regression with 2.6.39-rc1 on either OMAP4430SDP or
> Blaze,
> logs below:
> 
> Blaze log : http://pastebin.com/mGB5uD7P
> SDP log : http://pastebin.com/A5uAFfsr

Hmmm... right.  Actually I have now changed rootwait for rootdelay in my
kernel parameters and it worked fine with my setup too.  This is weird,
shouldn't rootwait cause the kernel to wait indefinitely until the root
device shows up?

-- 
Cheers,
Luca.

