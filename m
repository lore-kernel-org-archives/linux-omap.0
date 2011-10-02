From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 10/30] ARM: omap/iommu: always provide iommu debug code
Date: Sun, 2 Oct 2011 18:34:52 +0200
Message-ID: <CAK=WgbY-1VU5tJNxaJmP+8xqxV+XHjFeV=hjmxpZNuQJdKg=BQ@mail.gmail.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-11-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:47270 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab1JBQfN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 12:35:13 -0400
In-Reply-To: <1317566760-25681-11-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Roedel, Joerg" <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Sun, Oct 2, 2011 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The iommu module on omap contains a few functions that are
> only used by the debug module. These are however only there
> when the debug code is built as a module. Since it is possible
> to build the debug code into the kernel, the functions should
> also be provided for the built-in case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =A0arch/arm/plat-omap/iommu.c | =A0 =A02 +-

Thanks, Arnd.

The driver has moved to drivers/iommu/ and changed a bit, but this
patch is still relevant.

The merge conflict will be trivial to resolve, but if you prefer, we
can prevent it by taking this patch via the iommu tree.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
