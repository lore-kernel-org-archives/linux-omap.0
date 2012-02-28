From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Latest OMAP4 build errors
Date: Tue, 28 Feb 2012 11:51:05 +0200
Message-ID: <CAK=WgbZeeLxewPhxVpcAsNNeKYuzLojDZUm_=GmUgSh8kwvWUQ@mail.gmail.com>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43388 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab2B1JvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 04:51:25 -0500
Received: by iagj37 with SMTP id j37so976859iag.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 01:51:25 -0800 (PST)
In-Reply-To: <20120228090209.GC18045@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Tue, Feb 28, 2012 at 11:02 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> 1. It selects OMAP_IOMMU which may not have its dependencies satisfie=
d.

I'll select IOMMU_SUPPORT too (I prefer selecting here rather than
depending, because users may have hard time realizing they need to
enable omap's iommu first in order for omap's remoteproc option to
show up).

> 2. It's a new feature. =A0It is experimental. =A0It should not defaul=
t to 'm'

I'll set it to 'n' (by removing that line altogether).

Thanks for reporting this, Russell.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
