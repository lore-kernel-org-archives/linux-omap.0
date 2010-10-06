From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/7] [RFC] OMAP: hwmod implementation for MCBSP
Date: Wed, 6 Oct 2010 09:01:59 +0300
Message-ID: <201010060901.59829.peter.ujfalusi@nokia.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com> <1286296662-7639-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:45398 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab0JFGCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 02:02:04 -0400
In-Reply-To: <1286296662-7639-4-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "nskamat@ti.com" <nskamat@ti.com>, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Partha Basak <p-basak2@ti.com>

On Tuesday 05 October 2010 19:37:39 ext Kishon Vijay Abraham I wrote:
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Cc: Partha Basak <p-basak2@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c             |  251
> +++++++++---------------------- arch/arm/plat-omap/include/plat/mcbsp=
=2Eh |=20
>   6 +-
>  arch/arm/plat-omap/mcbsp.c              |  189 +++++++++++----------=
---
>  3 files changed, 159 insertions(+), 287 deletions(-)

So the plan is to kill OMAP1 support in McBSP (audio)?=20
We do have OMAP1 users, so IMHO dropping OMAP1 is not acceptable.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
