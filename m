From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 12:21:28 +0100
Message-ID: <20101116122128.5c6cc050@surf>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>
	<1289849261-29767-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41133 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab0KPLVh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 06:21:37 -0500
In-Reply-To: <1289849261-29767-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Hello,

On Mon, 15 Nov 2010 13:27:39 -0600
Nishanth Menon <nm@ti.com> wrote:

> +	/*
> +	 * Allow multiple calls, but initialize only if not already initalized

Minor: s/initalized/initialized/.

> +	 * even if the previous call failed, coz, no reason we'd succeed again
> +	 */
> +	if (omap_table_init)
> +		return 0;
> +	omap_table_init = 1;

Do we really need this ? I personaly don't really like this quite of
"Hey, I'm already initialized, let's do nothing silently then". Unless
there are strong reasons for which this function could be called twice,
I'd rather not have this, or turn this into a BUG_ON(omap_table_init ==
1).

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
