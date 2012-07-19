From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Thu, 19 Jul 2012 05:27:36 -0500
Message-ID: <CAOMWX4d9wBS2dx_6S9ouMagUPnAr3q8TYXpGq52nREfGHxVEUg@mail.gmail.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-5-git-send-email-t-kristo@ti.com> <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
 <1342602902.4672.91.camel@sokoban> <CAOMWX4dWnJSOwLVvrAfMd7a9eKE97ywR0TrS6imHFA67V5QZag@mail.gmail.com>
 <1342691380.4672.123.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:57436 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329Ab2GSK17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 06:27:59 -0400
Received: by wibhq4 with SMTP id hq4so1821407wib.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 03:27:56 -0700 (PDT)
In-Reply-To: <1342691380.4672.123.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jul 19, 2012 at 4:49 AM, Tero Kristo <t-kristo@ti.com> wrote:
>
> Zero doesn't mean no context loss. If counter was previous MAX_INT, if
> it goes to zero it is still a context loss, as the counter value
> differs. Drivers do check against diff in the context loss counter, and
> if there is one, they do restore which is the right way to handle it. No
> need to unnecessarily make this more complicated than it is.

so we flip the responsibility of overflow to drivers. considering a
similar scenario of jiffies
/*
 *      These inlines deal with timer wrapping correctly. You are
 *      strongly encouraged to use them
 *      1. Because people otherwise forget
 *      2. Because if the timer wrap changes in future you won't have to
 *         alter your driver code.
 *
 * time_after(a,b) returns true if the time a is after time b.
...
*/
from past experience, it is highly possible that drivers never get
this right. if the intent is just to let the drivers know context was
lost, why not go back to the alternate possibility of a bool
lost_context which tells the driver if it lost context since it last
called the lost_context api.

Regards,
Nishanth Menon
