From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP4+: Add DMM bindings
Date: Wed, 20 Mar 2013 11:29:59 +0530
Message-ID: <5149505F.7080105@ti.com>
References: <1363754624-5209-1-git-send-email-andy.gross@ti.com> <1363754624-5209-2-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51262 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab3CTF6L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 01:58:11 -0400
In-Reply-To: <1363754624-5209-2-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Gross <andy.gross@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Nishanth Menon <nm@ti.com>

On Wednesday 20 March 2013 10:13 AM, Andy Gross wrote:
> Add DMM bindings for OMAP4 and OMAP5 devices.
> 
> Signed-off-by: Andy Gross <andy.gross@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |    7 +++++++
>  arch/arm/boot/dts/omap5.dtsi |    7 +++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
"Documentation/devicetree/bindings/arm/omap/dmm.txt |   16 ++++++++++++++++

You should add the bidning information along or before
adding the DT node. I see you have that in next patch.
You should move that as part of this patch to be
consistent. Otherwise patch looks fine to me.

Regards,
Santosh

