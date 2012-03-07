From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 10/13] gpio/omap: fix missing dataout context save
 in _set_gpio_dataout_reg
Date: Wed, 07 Mar 2012 13:03:50 +0100
Message-ID: <4F574EA6.4000807@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com> <1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:59450 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755480Ab2CGMDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:03:55 -0500
Received: by ggni4 with SMTP id i4so3241017ggn.40
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:03:53 -0800 (PST)
In-Reply-To: <1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
> There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
> which writes to dataout register and the dataout context must be saved.
> It is missing in the first function, _set_gpio_dataout_reg(). Fix this.
> 
> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Good catch. Is the suspend/resume caught this issue?

This can go as a fix as well.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
