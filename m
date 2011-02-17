From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 Mux FW question
Date: Thu, 17 Feb 2011 17:11:22 +0530
Message-ID: <1e14f38aeaa635e1c2374931fd406736@mail.gmail.com>
References: <4D5CFA13.7030608@ti.com> <1af78c6718e8f15c87c4ab50bfa04a41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33564 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab1BQLlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:41:24 -0500
Received: by mail-qy0-f172.google.com with SMTP id 34so4427991qyk.10
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 03:41:23 -0800 (PST)
In-Reply-To: <1af78c6718e8f15c87c4ab50bfa04a41@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, Archit Taneja <archit@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

(Avoid top posting please)
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sricharan R
> Sent: Thursday, February 17, 2011 5:05 PM
> To: Archit Taneja; Benoit Cousson; linux-omap@vger.kernel.org
> Subject: RE: OMAP4 Mux FW question
>
> Hi Archit,
>  Those control registers are not a part of the mux list.
>  So the mux framework does not support configuring them.
>  Only the pad mux registers are configured.

[....]

If they are not part of MUX registers then you could
use control APIs directly. They should work.

omap4_ctrl_pad_readl() and omap4_ctrl_pad_writel()

Regards,
Santosh
