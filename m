From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 3/3] Regulator: Added board-dependent code for TPS65023
Date: Tue, 19 May 2009 17:08:16 +0530
Message-ID: <5d5443650905190438qb6b2bf7pcaf45c3ad3c4864f@mail.gmail.com>
References: <1241795536-15758-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:60927 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbZESLiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 07:38:15 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2916869qwd.37
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 04:38:16 -0700 (PDT)
In-Reply-To: <1241795536-15758-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Anuj,

On Fri, May 8, 2009 at 8:42 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> wr=
ote:
> Added OMAP3 EVM specific code for TPS65023 in pmic.c file.
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =A0drivers/regulator/pmic.c | =A0 92 ++++++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 92 insertions(+), 0 deletions(-)
>

pmic.c itself is not a right name here along with the location. PMIC
can be from any manufacturer. Board specific code should always come
from arch/arm/mach-omapXX

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
