From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH/RFT 0/3] ARM: OMAP: PM: reduce overhead of pwrdm pre/post transitions
Date: Wed, 25 Apr 2012 02:01:45 +0300
Message-ID: <CANOLnOOBit16XSmKRKf8QasuGTiyChMVKKnLM8X0SWRMKaMJbg@mail.gmail.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37635 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758518Ab2DXXBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 19:01:46 -0400
Received: by iadi9 with SMTP id i9so1607593iad.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 16:01:46 -0700 (PDT)
In-Reply-To: <1335277420-29124-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Apr 24, 2012 at 5:23 PM, Kevin Hilman <khilman@ti.com> wrote:
> Here's a first pass attempt to reduce the overhead of the pre/post
> transitions by allowing them to be called per powerdomain and making
> them conditional on powerdomain transtions.
>
> This can be used for testing/measurements to see the reduction the
> latencies involved in entering/exiting idle with and without these
> patches.

Seems to have similar effect as my earlier test of simply commenting
out pre/post transitions (~4.4MB/s), so this definitely helps.

Tested-by: Grazvydas Ignotas <notasas@gmail.com>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
