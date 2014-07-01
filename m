From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv5 04/15] hwspinlock/core: add common OF helpers
Date: Tue, 1 Jul 2014 15:45:38 +0300
Message-ID: <CAK=WgbbZvBLT7U638fBfPjF7-MJaP=4WJcrT_fEg6Uu3cXRAyg@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com> <1398904476-26200-5-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:56737 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaGAMqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 08:46:00 -0400
Received: by mail-la0-f48.google.com with SMTP id el20so5772339lab.7
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 05:45:58 -0700 (PDT)
In-Reply-To: <1398904476-26200-5-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
> 2. The of_hwspin_lock_simple_xlate() is a simple default
>    translator function for hwspinlock provider implementations
>    that use a single cell number for requesting a specific lock
>    (relatively indexed) within a hwlock bank.

Do we have a use case today that require the xlate() method?

If not, let's remove it as we could always add it back if some new
hardware shows up that needs it.

As long as the dt data is unchanged, we should generally only add
kernel code that we really need.

> 3. The of_hwspin_lock_request_specific() API can be used by
>    hwspinlock clients to request a specific lock using the
>    phandle + args specifier. This function relies on the
>    implementation providing back a relative hwlock id within
>    the bank from the args specifier.

It seems to me we can just introduce a of_hwspin_lock_get_id() method
which will provide the global lock id to dt users, with which they
could just invoke the existing hwspin_lock_request_specific(). This
way we will have more common code between dt users and users who get
the lock id from a remote processor.

Thanks,
Ohad.
