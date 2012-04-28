From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH/RFT 3/3] ARM: OMAP3: PM: cleanup cam_pwrdm leftovers
Date: Sat, 28 Apr 2012 17:47:45 +0300
Message-ID: <CANOLnOPoTx8ypXrJnyXUh8tf1+d8bBXYRk09ZqV2uEe_=oSRyQ@mail.gmail.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
	<1335277420-29124-4-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36345 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2D1Orp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Apr 2012 10:47:45 -0400
Received: by iadi9 with SMTP id i9so2242783iad.19
        for <linux-omap@vger.kernel.org>; Sat, 28 Apr 2012 07:47:45 -0700 (PDT)
In-Reply-To: <1335277420-29124-4-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Apr 24, 2012 at 5:23 PM, Kevin Hilman <khilman@ti.com> wrote:
> commit e7410cf7 (02fdb03e69699f26e1370d0e51593dbc8a4e5265) moved
> mangement of cam_pwrdm to CPUidle but left some remnants behind,
> namely the call to clkcm_allo_idle() for the clockdomains in the MPU
> pwrdm. =C2=A0Remove these since they are not necessary and cause unwa=
nted
> latency in the idle path.

Only noticed this now; what does
02fdb03e69699f26e1370d0e51593dbc8a4e5265 refer to? Doesn't seem to be
resolving to anything here.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
