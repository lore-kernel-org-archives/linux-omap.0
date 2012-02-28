From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Latest OMAP4 build errors
Date: Tue, 28 Feb 2012 12:11:37 +0200
Message-ID: <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk>
 <CAK=WgbZeeLxewPhxVpcAsNNeKYuzLojDZUm_=GmUgSh8kwvWUQ@mail.gmail.com> <201202281001.23011.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38333 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab2B1KL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:11:57 -0500
Received: by iagj37 with SMTP id j37so996519iag.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 02:11:57 -0800 (PST)
In-Reply-To: <201202281001.23011.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Tue, Feb 28, 2012 at 12:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I think 'depends' would be better here, because selecting IOMMU_SUPPORT
> has other side-effects that a user might not want. It's just as likely
> that someone wants to disable IOMMU_SUPPORT and needs to find OMAP_REMOTEPROC
> as wanting to enable OMAP_REMOTEPROC and having to find IOMMU_SUPPORT.
>
> In most cases, the defconfig should just set both.

Ok, 'depends on' it is.

Thanks,
Ohad.
