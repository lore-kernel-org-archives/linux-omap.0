From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Fri, 24 Jun 2011 10:32:13 +0200
Message-ID: <BANLkTinqz=brUeZDWPZ7vTH3jvetB+PASw@mail.gmail.com>
References: <1308300725-12150-1-git-send-email-j-pihet@ti.com>
	<874o3g6q1g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43018 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1FXIcO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 04:32:14 -0400
Received: by qyk29 with SMTP id 29so180988qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 01:32:13 -0700 (PDT)
In-Reply-To: <874o3g6q1g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

Hi Kevin,

On Fri, Jun 24, 2011 at 2:17 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> Can you rebase/retest this on top of my pm-wip/idle-suspend branch,
> which now contains Russell's major cleanup to use the common code as
> well as an additional patch from me to remove the unncessary
> get_*_restore_pointer functions:
>
> [PATCH] OMAP3: PM: remove get_*_restore_pointer functions, directly use entry points

Sure I will rebase on your pm-wip/idle-suspend branch, with the
ENDPROC fix as well as the v7_processor_functions patch applied.

>
> Thanks,
>
> Kevin

Regards,
Jean
