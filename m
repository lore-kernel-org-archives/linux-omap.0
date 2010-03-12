From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] arm: Fix .gitignore for boot/compressed folder
Date: Fri, 12 Mar 2010 11:51:57 -0600
Message-ID: <A24693684029E5489D1D202277BE894453FB180F@dlee02.ent.ti.com>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47919 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab0CLRwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 12:52:15 -0500
In-Reply-To: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Albin Tonnerre <albin.tonnerre@free-electrons.com>, Russell King <rmk@arm.linux.org.uk>

From: Aguirre, Sergio
Sent: Thursday, February 25, 2010 9:56 AM
> This should complements changes done in:
> 
>   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
>   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>   Date:   Fri Jan 8 14:42:43 2010 -0800
> 
>       arm: add support for LZO-compressed kernels
> 
> It missed to do the respective changes in '.gitignore' file.

Hi,

I did not receive any reply about this patch so far.

- Is it acceptable?
- Should I resend it somewhere else?

Regards,
Sergio

> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/boot/compressed/.gitignore |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/.gitignore
> b/arch/arm/boot/compressed/.gitignore
> index ab204db..bb984af 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,5 @@
>  font.c
> -piggy.gz
> +piggy.gzip
> +piggy.lzo
> +lib1funcs.S
>  vmlinux.lds
> --
> 1.6.3.3

