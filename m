From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Sun, 19 Apr 2009 18:58:21 +0300
Message-ID: <87prf8skiq.fsf@litku.valot.fi>
References: <873ac7ko2n.fsf@litku.valot.fi> <20090419050020.GC1736@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f211.google.com ([209.85.218.211]:59029 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758883AbZDSP6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Apr 2009 11:58:25 -0400
Received: by bwz7 with SMTP id 7so826923bwz.37
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2009 08:58:23 -0700 (PDT)
In-Reply-To: <20090419050020.GC1736@swansys> (green's message of "Sat\, 18 Apr 2009 23\:00\:20 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

green <greenfreedom10@gmail.com> writes:

> Kalle Valo wrote at 2009-04-17 14:44 -0600:
>
>> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_wait'=
:
>> arch/arm/kernel/sys_oabi-compat.c:289: error: implicit declaration o=
f function 'kmalloc'
>> arch/arm/kernel/sys_oabi-compat.c:289: warning: assignment makes poi=
nter from integer without a cast
>> arch/arm/kernel/sys_oabi-compat.c:302: error: implicit declaration o=
f function 'kfree'
>> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_semtimedop'=
:
>> arch/arm/kernel/sys_oabi-compat.c:325: warning: assignment makes poi=
nter from integer without a cast
>
> I see nearly the same:
>
> arch/arm/kernel/sys_oabi-compat.c: In function =91sys_oabi_epoll_wait=
=92:
> arch/arm/kernel/sys_oabi-compat.c:288: error: implicit declaration of=
 function =91kmalloc=92
> arch/arm/kernel/sys_oabi-compat.c:288: error: =91GFP_KERNEL=92 undecl=
ared (first use in this function)

I think that's the same error. Most probably my tree was dirty and
that's the line numbers are different.

--=20
Kalle Valo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
