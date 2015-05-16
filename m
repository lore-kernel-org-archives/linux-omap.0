From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Sat, 16 May 2015 10:18:08 +0300
Message-ID: <CAK=WgbZGYa-xWE_cxPA1aq50kK2NBdQfhQHX+sPyowky6Syekg@mail.gmail.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
 <1427917039-43206-2-git-send-email-d-gerlach@ti.com> <CAK=WgbZCqnMPEnU2992gkOp07BaCP5NJNRO-hLCAdOtUXZGRnQ@mail.gmail.com>
 <5550C644.4040005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36420 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbbEPHS3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2015 03:18:29 -0400
Received: by iepk2 with SMTP id k2so138432469iep.3
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2015 00:18:29 -0700 (PDT)
In-Reply-To: <5550C644.4040005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>

Hi Suman,

On Mon, May 11, 2015 at 6:09 PM, Suman Anna <s-anna@ti.com> wrote:
> On 05/09/2015 02:39 AM, Ohad Ben-Cohen wrote:
> > On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> >> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
> >> remove the get_by_name/put API") for the ref counting a rproc klist
> >> code but has rproc_get_by_name replaced with an rproc_get_by_phandle API.
> >
> > The general idea makes sense to me, but I'm not sure we really do need
> > a klist here, since the usage profile of this list is expected to be
> > super simple: very small number of accessors, looking for small number
> > of list members a small number of times, and probably never do need to
> > modify the list while accessing it.
> >
> > I suspect that the code would be simpler to maintain, debug and
> > understand if we just use a simple list with a simple locking
> > methodology here.
>
> The klist usage is something that we restored from previous remoteproc
> core code as used by the rproc_get_by_name() API. This was removed in
> commit 40e575b1d0b3 ("remoteproc: remove the get_by_name/put API"). We
> chose to use the code that had been present before rather than inventing
> something new all over again. If you feel that a regular list is the way
> to go forward, we can make the switch.

Yes, please. Using a regular list with a simple locking methodology
should make the code easier to understand and debug.

Thanks,
Ohad.
