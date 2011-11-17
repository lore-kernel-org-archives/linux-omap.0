From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] arm: omap2: fix build failure
Date: Thu, 17 Nov 2011 11:00:18 +0800
Message-ID: <CACVXFVMtaiFiKSRh8geVpOzymtZsaUKc9tDHfgJYR57N+RQZ-g@mail.gmail.com>
References: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
	<87mxc61kpw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59392 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab1KQDAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 22:00:19 -0500
Received: by wwe5 with SMTP id 5so1996982wwe.1
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 19:00:18 -0800 (PST)
In-Reply-To: <87mxc61kpw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Nov 9, 2011 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> tom.leiming@gmail.com writes:
>
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> The patch fixes the compile failure:
>>
>> =A0 CC =A0 =A0 =A0arch/arm/mach-omap2/cpuidle34xx.o
>> arch/arm/mach-omap2/cpuidle34xx.c:317:12: error: 'THIS_MODULE'
>> undeclared here (not in a function)
>> make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
>> make: *** [arch/arm/mach-omap2] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>
> FYI...
>
> Tony has already queued fix for this in his fixes branch.
>
> =A0 =A0 http://marc.info/?l=3Dlinux-arm-kernel&m=3D132071036621713&w=3D=
2

The fix is not merged into 3.2.0-rc2-next-20111116+ yet...

thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
