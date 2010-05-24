From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 24 May 2010 19:19:42 +0300
Message-ID: <AANLkTimr6_rmx3_wQSc4nnVqZyi2dLu26d6Y8Cd2MMCB@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	<AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	<AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	<AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
	<AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
	<AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
	<AANLkTimeUwfnmj5pcabFuqGKZ2ExEcf-GPopGDjeV-XB@mail.gmail.com>
	<AANLkTimAZLGNQsOCqHsk5QbbquIoDIYCtIW2NJqVcoup@mail.gmail.com>
	<AANLkTim9HXNk-9P_lGtGy32lLQrVl2bfN-qKTY5Qm9xR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37028 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab0EXQUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 12:20:04 -0400
Received: by gyg13 with SMTP id 13so1558675gyg.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 09:20:04 -0700 (PDT)
In-Reply-To: <AANLkTim9HXNk-9P_lGtGy32lLQrVl2bfN-qKTY5Qm9xR@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Fri, May 21, 2010 at 12:42 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Although I'm still worried that VM_IO != write-combine, but I guess
> it's a safe assumption to do for now.

small update we missed:

The original code is ignoring VM_IO buffers as well:

static int memory_sync_vma(unsigned long start, u32 len,
			   enum dsp_flushtype ftype)
{
...
		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
			return -EINVAL;
...
}

So the new code is actually behaving in exactly the same manner
(besides the error code, which is now -EFAULT and not -EINVAL).
