From: =?ISO-8859-1?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>
Subject: Re: OMAP baseline test results for v3.6-rc4
Date: Sat, 8 Sep 2012 01:01:22 +0200
Message-ID: <CALbNGRTB_etDtD-NTKgNu51tyg=F4YpYMzEkdfhFiGFgyX-uXw@mail.gmail.com>
References: <alpine.DEB.2.00.1209051523340.11516@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59473 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304Ab2IGXBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 19:01:23 -0400
Received: by obbuo13 with SMTP id uo13so197885obb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 16:01:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209051523340.11516@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Wed, Sep 5, 2012 at 5:44 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Here are some basic boot and power management test results for v3.6-rc4:
>
>     http://www.pwsan.com/omap/testlogs/test_v3.6-rc4/20120904122415/
>
> Some observations:
>
> * N800: panics during kernel init
>   - This is caused by an MMC driver bug; fixed by "[PATCH] MMC: OMAP MSDI:
>     fix broken PIO mode", available from here:
>     http://www.spinics.net/lists/arm-kernel/msg190879.html
>
> * CM-T3517: L3 in-band error with USB OTG during boot
>   - Cause unknown; longstanding issue; does not occur on the 3517EVM
>
> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to
>     off works
>
> * 4430ES2 Panda: CORE, L4PER, L3INIT, TESLA, IVAHD not going idle
>   - Cause unknown; may be partially due to McPDM reset problem
>
> (The objective in posting these is to determine what is and isn't working
> in the mainline releases, as well as to make it easier to determine what
> is fixed or is broken by subsequent series that use this as a base.)
>
I did not find that - maybe I missed something: Could you also store
the resulting configs of theses tests?

Andreas
