From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Wed, 6 Mar 2013 08:58:45 -0300
Message-ID: <CALF0-+VeU9tGy-dKgmVg1pT0z0ghJBSsughV7kzT5nX7u=9BhA@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
	<1361899842-30303-12-git-send-email-jon-hunter@ti.com>
	<51360271.1030302@mimc.co.uk>
	<51360562.20309@ti.com>
	<51361B46.507@mimc.co.uk>
	<51362BAB.10403@ti.com>
	<513664EC.2050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:57943 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802Ab3CFL6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 06:58:47 -0500
Received: by mail-la0-f53.google.com with SMTP id fr10so7128530lab.26
        for <linux-omap@vger.kernel.org>; Wed, 06 Mar 2013 03:58:46 -0800 (PST)
In-Reply-To: <513664EC.2050508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

Jon,

On Tue, Mar 5, 2013 at 6:34 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> By the way, with this version you should remove "simple-bus" from your
> gpmc node compatible strings. I now call of_platform_device_create() to
> create the child device during the GPMC probe. I think that this is a
> safer approach.
>

FWIW, using of_platform_device_create() works for my driver.
It seems as simple as using a compatible 'simple-bus',
with the advantage that it allows to create and probe the
child device from its parent.

I'll submit this driver by the end of this week, in case you want
to take a look at it.

Thanks a lot,
-- 
    Ezequiel
