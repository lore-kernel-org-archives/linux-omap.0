From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC v3 PATCH 1/3] dt: device tree bindings for DDR memories
Date: Thu, 19 Jan 2012 11:31:09 -0800
Message-ID: <CAOesGMikm8szKR_yyeV-4NbnknCLG3z9N_sj+zydyu+cosj-Tg@mail.gmail.com>
References: <1326983521-373-1-git-send-email-aneesh@ti.com>
	<1326983521-373-2-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52203 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab2ASTbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 14:31:09 -0500
Received: by yhoo21 with SMTP id o21so200045yho.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 11:31:09 -0800 (PST)
In-Reply-To: <1326983521-373-2-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi,

Sorry for the delay in responding, I know you pinged me about it yesterday.

On Thu, Jan 19, 2012 at 6:31 AM, Aneesh V <aneesh@ti.com> wrote:
> device tree bindings for LPDDR2 SDRAM memories compliant
> to JESD209-2 standard.
>
> The 'lpddr2' binding in-turn uses another binding 'lpddr2-timings'
> for specifying the AC timing parameters of the memory device at
> different speed-bins.

As I just commented on the thread with Mike, I think we would be
better off sticking to embedding a standard JEDEC SPD structure in the
device tree. It's not large (128-256 bytes depending on memory type),
and it's clearly defined and used all over the industry.

It also has the benefit of reusing parsing code if you ever end up
with a system that uses DIMMs for memory, thus needing to parse the
SPD on said modules.


-Olof
