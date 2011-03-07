From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 3/7] omap3: pm: TWL4030 power scripts for OMAP3 boards
Date: Mon, 07 Mar 2011 13:02:43 -0800
Message-ID: <87y64q4pak.fsf@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-4-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39784 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261Ab1CGVCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 16:02:48 -0500
Received: by mail-yx0-f169.google.com with SMTP id 33so2300077yxt.14
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 13:02:47 -0800 (PST)
In-Reply-To: <1299072653-13414-4-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Wed, 2 Mar 2011 19:00:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.
>
> TWL4030 power scripts which can be used by different OMAP3 boards
> with the power companion chip (TWL4030 series).
>
> The twl4030 generic script is exported and can be used by any other
> boardfile to update the power data in twl4030_platform_data.
>
> http://omapedia.org/wiki/TWL4030_power_scripts

This is a very helpful wiki page, thanks for writing that up.

I'd recommend putting a link into the C file as well, saying this code
implements the recommended sequence as detailed at <wiki page>.

One minor nit on naming here.  I think you should use the public name
TWL4030 throughout instead of Triton (which AFAIK, is not an acronym and
should not be capitalized.)

Kevin

