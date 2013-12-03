From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
Date: Tue, 3 Dec 2013 09:53:22 +0000
Message-ID: <20131203095322.GG11828@lee--X1>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54275 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab3LCJx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 04:53:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so22772680iec.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Dec 2013 01:53:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131203095136.GF11828@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, sameo@linux.intel.com, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> The code looks mostly fine, but the implementation of the commit logs
> seems lazy. Please submit a v3 using coherent sentences with full
> explanations and correct punctuation.

Also use the full length of the provided buffer, which I believe is 72
chars, but happy to be correct on that one. It's certainly not 40
chars however.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
