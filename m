From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Mon, 15 Nov 2010 23:51:53 +0100
Message-ID: <20101115235153.25f7021e@surf>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>
	<1289849261-29767-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44575 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab0KOWwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 17:52:02 -0500
In-Reply-To: <1289849261-29767-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Hello,

On Mon, 15 Nov 2010 13:27:39 -0600
Nishanth Menon <nm@ti.com> wrote:

> +++ b/arch/arm/mach-omap2/opp3xxx_data.h
> +
> +static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
> +
> +static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {

Do we really want to have structure definitions in an header file ?
Unless I'm wrong, this means that if the opp3xxx_data.h file is
included in two different C files, the structures will be present twice.

As far as I could see, most of the kernel instantiate structure in C
files instead.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
