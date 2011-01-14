From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Fri, 14 Jan 2011 22:37:01 +0200
Message-ID: <20110114223701.11e0f7d1.jhnikula@gmail.com>
References: <20110114194758.GM4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41822 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1ANUe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 15:34:57 -0500
Received: by eye27 with SMTP id 27so1705092eye.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 12:34:56 -0800 (PST)
In-Reply-To: <20110114194758.GM4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

On Fri, 14 Jan 2011 11:47:58 -0800
Tony Lindgren <tony@atomide.com> wrote:

> - omap4 panda powers down after boot (watchdog?)
> 
> - omap3 ldp board powers down after boot?
> 
my 2c to Panda power down problem:

Nishanth helped me recently to debug why my board does this power down
and it seems to be caused by a broken hw. I.e. we were using exactly
same bootloader and kernel and only my board was not working.

-- 
Jarkko
