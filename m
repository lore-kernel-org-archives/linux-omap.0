From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] tidspbridge: remove revision history
Date: Mon, 16 Mar 2009 23:50:10 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF5A499A@dlee02.ent.ti.com>
References: <1237241138-4516-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbZCQEuZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 00:50:25 -0400
In-Reply-To: <1237241138-4516-1-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Contreras
> Sent: Tuesday, March 17, 2009 12:06 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Hiroshi DOYU; Ameya Palande; Guzman Lugo, Fernando;
> Felipe Contreras
> Subject: [PATCH] tidspbridge: remove revision history
> 
> No need for that with git.
> diff --git a/drivers/dsp/bridge/gen/_gt_para.c
> b/drivers/dsp/bridge/gen/_gt_para.c
> index 181fe41..b363590 100644
> --- a/drivers/dsp/bridge/gen/_gt_para.c
> +++ b/drivers/dsp/bridge/gen/_gt_para.c
> @@ -24,14 +24,6 @@
>   *      etc. into a fully bound image.  Thus, GT_assert() can be retained
> in
>   *      a program for which GT_?trace() has been compiled out.
>   *
> - *! Revision History:
> - *! ================
> - *! 24-Feb-2003 vp: Code Review Updates.
> - *! 18-Oct-2002 sb: Ported to Linux platform.
> - *! 03-Jul-2001 rr: Removed kfuncs.h because of build errors.
> - *! 07-Dec-1999 ag: Fxn error now causes a WinCE DebugBreak;
> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
> - *!
But we did not have git history 1999-2003. we planning on loosing these contribs?

Regards,
Nishanth Menon
