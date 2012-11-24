From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP4: MPUSS PM: remove unnecessary shim functions
 for powerdomain control
Date: Sat, 24 Nov 2012 11:34:13 +0530
Message-ID: <50B0635D.2050700@ti.com>
References: <20121124033809.24638.11090.stgit@dusk.lan> <20121124034237.24638.3621.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55013 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab2KXGEW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Nov 2012 01:04:22 -0500
In-Reply-To: <20121124034237.24638.3621.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

On Saturday 24 November 2012 09:12 AM, Paul Walmsley wrote:
> The OMAP4 MPU subsystem power management code contains several unnecessary
> shim functions for powerdomain control; remove them.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
Most of them are inline functions so final object code
will mostly same after and before the patch.
But cleaning these helpers is better I guess. So..

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>



