From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when disabling
	interrupts, v2"
Date: Sat, 23 May 2009 09:47:25 +0900
Message-ID: <4d34a0a70905221747x4453afccwe87765a2be853c7f@mail.gmail.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
	<1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
	<4A15E5D9.7090704@samsung.com> <87hbzd89xz.fsf@deeprootsystems.com>
	<20090522232206.GA6999@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:25973 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128AbZEWAro convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 20:47:44 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1440761qwd.37
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 17:47:45 -0700 (PDT)
In-Reply-To: <20090522232206.GA6999@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Kim Kyuwon <q1.kim@samsung.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sat, May 23, 2009 at 8:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 22, 2009 at 07:54:32AM -0700, Kevin Hilman wrote:
>> But the implemenation of that should not hold up this revert because
>> this patch breaks *all* wakeups since the PRCM interrupt itself is
>> disabled in the suspend path.
>
> That is not mentioned in the patch description (and it should be).
> What this paragraph is saying is that this revert is most definitely
> fixing a regression.
>
> Any "fix" which causes other breakage is not a fix, and therefore
> this revert needs to go in no matter what.

The problem is that this patch(which is written by me) was merged much
earlier than Rafael's patch. So I think Rafael's patch causes other
breakage.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
