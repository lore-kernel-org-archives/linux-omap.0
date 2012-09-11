From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] omap: remoteproc: set bootaddr support
Date: Tue, 11 Sep 2012 15:30:54 +0300
Message-ID: <CAK=Wgbb6EKS1YqR89y08stkwz3zFw786J3an2iDT+rKFWyo+5A@mail.gmail.com>
References: <1345044348-19898-1-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51513 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2IKMbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 08:31:15 -0400
Received: by vcbfy27 with SMTP id fy27so492564vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 05:31:14 -0700 (PDT)
In-Reply-To: <1345044348-19898-1-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Juan,

On Wed, Aug 15, 2012 at 6:25 PM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> Some remote processors (like Omap4's DSP) need to explicitly
> set a boot address from which they start executing code when
> taken out of reset.
>
> Support for this has been added to remoteproc code through
> a set_bootaddr function in the platform data which, if needed,
> must be set according to the backend rproc.
>
> For omap4's dsp we can use the next control funtion:
>
>   .set_bootaddr  = omap_ctrl_write_dsp_boot_addr
>
> Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>

Applied with slight changes to the commit log. Thanks!

Ohad.
