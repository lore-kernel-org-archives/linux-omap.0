From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v5 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Thu, 18 Jun 2015 12:04:16 +0300
Message-ID: <CAK=Wgbb1e6O574Bpicy4Y623vtiigauT22H-zk+JXGCz070i5g@mail.gmail.com>
References: <1432327530-48032-2-git-send-email-d-gerlach@ti.com> <1434566762-40702-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36091 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbbFRJEh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2015 05:04:37 -0400
Received: by igbiq7 with SMTP id iq7so86582587igb.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2015 02:04:36 -0700 (PDT)
In-Reply-To: <1434566762-40702-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Dave,

On Wed, Jun 17, 2015 at 9:46 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Allow users of remoteproc the ability to get a handle to an rproc by
> passing a phandle supplied in the user's device tree node. This is
> useful in situations that require manual booting of the rproc.
>
> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
> remove the get_by_name/put API") for the ref counting but is modified
> to use a simple list and locking mechanism and has rproc_get_by_name
> replaced with an rproc_get_by_phandle API.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v4->v5: Fixed build error from of_find_node_by_phandle when !CONFIG_OF
>         based on offline discussion.

We can't rebase our for-next branch, so I've applied a
similar fix in a separate patch.

Please check our for-next branch to make sure things still work for you.

Thanks,
Ohad.
