From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 08/21] OMAP3+: Smartreflex: Add a shutdown hook
Date: Thu, 26 Jan 2012 15:21:41 +0400
Message-ID: <4F213745.3040807@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com> <1327504583-13408-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:53362 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752744Ab2AZLWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 06:22:50 -0500
In-Reply-To: <1327504583-13408-9-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> Since OMAP's VP and PRM modules do not get reset by warm reset,
> we should ensure that proper shutdown procedure is followed prior
> to allowing the kernel to reboot back up.
>
> Without this patch, Smartreflex module might be left active or
> system might be caught in an indeterminate sequence when reboot
> is triggered, leaving the next reboot behavior to be unpredictable.

> Change-Id: I7f8c66cc45f8785394cce1fdde3cfda15ecc1fbc

    This line has no place in the upstream patch, please remove it.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++++++++++++
>   1 files changed, 24 insertions(+), 0 deletions(-)

WBR, Sergei
