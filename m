From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 Feature list buggy
Date: Mon, 8 Nov 2010 09:02:23 +0200
Message-ID: <20101108070223.GH1818@legolas.emea.dhcp.ti.com>
References: <AANLkTingmCrQGX9RQpYy0vgSbgLt+F6exgbnsMP0CuXY@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43704 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765Ab0KHHBT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 02:01:19 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTingmCrQGX9RQpYy0vgSbgLt+F6exgbnsMP0CuXY@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Nov 05, 2010 at 10:08:13AM -0500, Arno Steffen wrote:
>There is a copy/paste bug in arch/arm/plat-omaop/include/control:
>
>Please replace:
>
>#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
>
>by:
>
>#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)

care to send a patch ?

-- 
balbi
