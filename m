From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [patch v4 3/3] arm: omap4: support pmu
Date: Sat, 14 May 2011 16:48:52 +0800
Message-ID: <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54591 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab1ENIsx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 May 2011 04:48:53 -0400
Received: by gwaa18 with SMTP id a18so1113037gwa.19
        for <linux-omap@vger.kernel.org>; Sat, 14 May 2011 01:48:52 -0700 (PDT)
In-Reply-To: <BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Woodruff Richard <r-woodruff2@ti.com>, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org

Hi Rabin,

2011/5/14 Rabin Vincent <rabin@rab.in>:
> What happened to this patch? =A0It is neither in mainline nor in
> linux-next.
>

This patch depends on the two with titles:

      introduce cross trigger interface helpers
      pmu: allow platform specific irq enable/disable handling

and the above patches have been submitted to RMK's patch system
as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk,
so I can't ask omap guys to merge this one into their tree now.


thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
