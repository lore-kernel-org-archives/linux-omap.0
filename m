From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] OMAP: PM: enable UART clock disabling when idle
Date: Sat, 29 Nov 2008 14:52:10 +0200
Message-ID: <94a0d4530811290452o53df8811x697bcfa49660118a@mail.gmail.com>
References: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:39501 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYK2MwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Nov 2008 07:52:12 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1719948rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 29 Nov 2008 04:52:11 -0800 (PST)
In-Reply-To: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, Nov 27, 2008 at 2:29 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> This series enables UART clock disabling after an inactivity period.
> It is based on top of the 2 8250 patches recently sent to linux-serial
> and CC'd to linux-omap.
>
> To enable:
>
>  # echo 1 > /sys/power/clocks_off_while_idle
>  # echo 1 > /sys/power/sleep_while_idle
>
> NOTE: it is expected that the first character typed is lost
> when coming out of idle.  The first char serves as the wakeup
> event but is lost.

Agh, can that be avoided somehow?

-- 
Felipe Contreras
