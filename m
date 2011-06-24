From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Fri, 24 Jun 2011 07:42:07 -0700
Message-ID: <87y60r47gg.fsf@ti.com>
References: <1308300725-12150-1-git-send-email-j-pihet@ti.com>
	<874o3g6q1g.fsf@ti.com>
	<BANLkTinqz=brUeZDWPZ7vTH3jvetB+PASw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50903 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758105Ab1FXOmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 10:42:11 -0400
Received: by mail-pw0-f45.google.com with SMTP id 5so2348361pwi.18
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 07:42:10 -0700 (PDT)
In-Reply-To: <BANLkTinqz=brUeZDWPZ7vTH3jvetB+PASw@mail.gmail.com> (Jean
	Pihet's message of "Fri, 24 Jun 2011 10:32:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Fri, Jun 24, 2011 at 2:17 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Hi Jean,
>>
>> Can you rebase/retest this on top of my pm-wip/idle-suspend branch,
>> which now contains Russell's major cleanup to use the common code as
>> well as an additional patch from me to remove the unncessary
>> get_*_restore_pointer functions:
>>
>> [PATCH] OMAP3: PM: remove get_*_restore_pointer functions, directly use entry points
>
> Sure I will rebase on your pm-wip/idle-suspend branch, 

Thanks.

> with the
> ENDPROC fix as well as the v7_processor_functions patch applied.

Russell already has those fixed in his branch, so my pm-wip/idle-suspend
already includes these.

Thanks,

Kevin
