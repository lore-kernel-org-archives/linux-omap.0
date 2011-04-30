From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: problem with "undefined instruction"
Date: Sat, 30 Apr 2011 17:44:46 +0100
Message-ID: <yw1xwribr8n5.fsf@unicorn.mansr.com>
References: <20110430162357.GA14287@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59229 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab1D3QpB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 12:45:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QGDHw-0001Xl-6L
	for linux-omap@vger.kernel.org; Sat, 30 Apr 2011 18:45:00 +0200
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 18:45:00 +0200
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 18:45:00 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sebastian Reichel <sre@debian.org> writes:

> Hi,
>
> I'm currently trying to get a mainline based kernel running on my pan=
daboard.
> The problem is, that it's crashing very early during the init phase b=
ecause of
> "undefined instruction" exceptions:
>
> [    1.867980] udevd (56): undefined instruction: pc=3D401e6ed4
> [    1.874603] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    1.977752] modprobe (69): undefined instruction: pc=3D400c6ed4
> [    1.977783] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    1.978240] init (1): undefined instruction: pc=3D40149ed4
> [    1.978240] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    2.005706] Kernel panic - not syncing: Attempted to kill init!
>
> Exactly the same userland boots fine with the original 2.6.35 kernel,=
 so it's
> probably not the userland's fault. But I searched for the byte combin=
ation
> anyway and found it in libc.so:
>
>    32ecc:   9cd0        ldr r4, [sp, #832]  ; 0x340
>    32ece:   fffe e92d   vtbl.8  d30, {d14-d15}, d29
>
> 00032ed0 <_IO_vfprintf>:
>    32ed0:   e92d 4ff0   stmdb   sp!, {r4, r5, r6, r7, r8, r9, sl, fp,=
 lr}
>    32ed4:   ed2d 8b02   vpush   {d8}

Your userland appears to be built with Thumb2.  Make sure CONFIG_THUMB
is enabled in your kernel.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
