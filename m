From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: MMC3 Overo
Date: Wed, 5 Aug 2009 11:32:30 +0300
Message-ID: <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:64141 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933555AbZHEIcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 04:32:31 -0400
Received: by fxm28 with SMTP id 28so3626863fxm.17
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 01:32:31 -0700 (PDT)
In-Reply-To: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> <u-boot_snip>
> =A0MUX_VAL(CP(ETK_CLK_ES2), =A0 =A0 =A0 (IDIS | PTU | EN =A0| M2)) /*=
MMC3_CLK*/\

You must have input enable on CLK line for MMC3 or it won't work for
some reason (MMC 1 and 2 doesn't need that). Without this part of the
host controller hardware doesn't get the clock I guess, or something
like that. You won't believe how much time we've wasted on this!
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
