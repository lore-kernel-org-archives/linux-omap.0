From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Tue, 15 Feb 2011 17:29:31 +0200
Message-ID: <20110215172931.3a6e45a8.jhnikula@gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60054 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1BOP3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 10:29:09 -0500
Received: by eye27 with SMTP id 27so143502eye.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 07:29:08 -0800 (PST)
In-Reply-To: <20110215171652.601c9c68.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, 15 Feb 2011 17:16:52 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Would it make more sense to set only the flag here and do the register
> writes when omap3_twl_init is executing? Then it's not so strict when
> the board code calls this function.
> 
Probably discussed earlier but would it make more sense to have flag in
struct twl4030_platform_data and to do registers writes in twl-core?
Looks suspicious to have i2c_writes under arch/arm/.

-- 
Jarkko
