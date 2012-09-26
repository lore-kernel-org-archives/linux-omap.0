From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: tidspbridge build fails
Date: Tue, 25 Sep 2012 19:35:36 -0500
Message-ID: <CAJ6Av5M2fNRvR275rFX4ch+gYuCy+EJDRMex8MGfqLdXxq3QaA@mail.gmail.com>
References: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
	<loom.20120924T183345-467@post.gmane.org>
	<CAJ6Av5M4BWy709qLLz5HOjXL87GjTqyF6qQku-DSW1B2hNJxJQ@mail.gmail.com>
	<loom.20120925T193504-862@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56190 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2IZAfh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 20:35:37 -0400
Received: by ieak13 with SMTP id k13so94251iea.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 17:35:36 -0700 (PDT)
In-Reply-To: <loom.20120925T193504-862@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Selso LIBERADO <sli@cioinfoindus.fr>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 25, 2012 at 12:39 PM, Selso LIBERADO <sli@cioinfoindus.fr> wrote:
> Hi !
>
> Here what's happening when applying the patch :
>
> sli@SLI-V420:~/developpement/INTERNE/BEAGLEBOARD/logiciel/linux-omap$ git apply
> --check ../../archive/10-17-staging-tidspbridge-Prepare-for-irqs.h-removal.patch
> error: patch failed: drivers/staging/tidspbridge/core/wdt.c:25
> error: drivers/staging/tidspbridge/core/wdt.c: patch does not apply

Yes, got the same had to rework the patch to apply.

If you have the time, you could try:

git am --3way <patch>

Then resolve the conflicts[1].

> newbie question : Where is the staging-next rep ?

http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=summary

Regards,

Omar

---
[1] http://www.kernel.org/pub/software/scm/git/docs/v1.7.3/user-manual.html#resolving-a-merge
