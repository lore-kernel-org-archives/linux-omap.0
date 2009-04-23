From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] ARM: OMAP: Fix tusb6010 init error and compilation warning
Date: Thu, 23 Apr 2009 20:06:39 +0300
Message-ID: <8763gvb8ps.fsf@litku.valot.fi>
References: <1240468227-15393-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:48638 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZDWRGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 13:06:43 -0400
Received: by bwz7 with SMTP id 7so659860bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 10:06:40 -0700 (PDT)
In-Reply-To: <1240468227-15393-1-git-send-email-jarkko.nikula@nokia.com> (Jarkko Nikula's message of "Thu\, 23 Apr 2009 09\:30\:27 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

Jarkko Nikula <jarkko.nikula@nokia.com> writes:

> Fix "tusb6010 init error 5, -19" and compilation warning from function
> tusb6010_platform_retime "warning: 'sysclk_ps' is used uninitialized in this
> function".
>
> I suppose commit c094ba34b8f780885d029ce3c2715a194b780e5d was meant to test
> for zero fclk_ps instead of sysclk_ps.

I was suffering exactly this problem and this patch fixed it. Now usb
network works again, thanks a lot for fixing this!

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Roel Kluin <roel.kluin@gmail.com>

Tested-by: Kalle Valo <kalle.valo@iki.fi>

-- 
Kalle Valo
