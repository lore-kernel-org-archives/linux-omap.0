From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 38/86] [ARM] OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
Date: Thu, 12 Mar 2009 14:32:51 -0700
Message-ID: <871vt25svw.fsf@deeprootsystems.com>
References: <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
	<1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702EA75D2CB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:48401 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbZCLVc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 17:32:57 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1377561wfa.4
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 14:32:54 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702EA75D2CB@dbde02.ent.ti.com> (Vikram Pandita's message of "Fri\, 13 Mar 2009 02\:09\:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Thursday, March 12, 2009 1:28 PM
>>To: linux-omap@vger.kernel.org
>>Subject: [PATCH 38/86] [ARM] OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
>
> Patch fails apply to kernel.org master: 0038
>
> Applying: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
> error: patch failed: arch/arm/mach-omap2/clock.c:571
> error: arch/arm/mach-omap2/clock.c: patch does not apply
>

Sorry, I forgot to mention this in PATCH 00/86.

This series is not against vanilla kernel.org.  It is against one of
Tony's 'omap-fixes' branches that Russell had already pulled in.

If you want to build/boot test, I suggest using Russell's branch
directly.

Kevin
