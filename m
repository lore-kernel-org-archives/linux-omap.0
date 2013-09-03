From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
Date: Tue, 3 Sep 2013 06:56:53 -0700
Message-ID: <CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
	<1377598305-15539-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:53039 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858Ab3ICN4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 09:56:54 -0400
Received: by mail-qc0-f182.google.com with SMTP id k18so2562437qcv.41
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 06:56:54 -0700 (PDT)
In-Reply-To: <1377598305-15539-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, bcousson@baylibre.com, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 27, 2013 at 3:11 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> Use drivers/misc/sram.c driver to manage SRAM on all DT only
> OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
> the existing private implementation.
>
> Address and size related data  is removed from mach-omap2/sram.c
> and now passed to drivers/misc/sram.c from DT.
>
> Users can hence use general purpose allocator apis instead of
> OMAP private ones to manage and use SRAM.
>
> Currently there are no users on SRAM on these platfoms.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

I was trying to experiment with this on am33xx, but I noticed that the
ioremap region is not marked exec, so it cannot be used to run code.
