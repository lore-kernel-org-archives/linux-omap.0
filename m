From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/19] OMAP3+: introduce SR class 1.5
Date: Thu, 03 Mar 2011 06:07:41 +0530
Message-ID: <4D6EE2D5.7040900@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <87aahdujox.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52886 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276Ab1CCAhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:37:48 -0500
Received: by mail-ew0-f42.google.com with SMTP id 1so245646ewy.15
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:37:47 -0800 (PST)
In-Reply-To: <87aahdujox.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 06:03 AM:
> - Please capitalize acronyms throughout the
>    subjects/comments/changelogs.  This series tends to mix lower-case and
>    upper case acronyms
Ack. thanks for catching it.

>
> - Please Cc linux-arm-kernel for patches intended for mainline.  Because
>    of this, I didn't (yet) queue the ones I said I would queue.
done that with v2 which I had happened to have posted yesterday :(:
http://marc.info/?l=linux-omap&m=129906334611444&w=2

>
> - Please rebase this on top of my pm-core branch (or Paul's
>    integration-2.6.39 branch if you prefer.)  There are some important
>    voltage related re-organization happening there that affects your code.
ok. will do that and integrate comments from v1 and v2 for v3..

-- 
Regards,
Nishanth Menon
