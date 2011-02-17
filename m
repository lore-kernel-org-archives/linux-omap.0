From: Sricharan R <r.sricharan@ti.com>
Subject: RE: OMAP4 Mux FW question
Date: Thu, 17 Feb 2011 17:05:18 +0530
Message-ID: <1af78c6718e8f15c87c4ab50bfa04a41@mail.gmail.com>
References: <4D5CFA13.7030608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38528 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab1BQLfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:35:22 -0500
Received: by mail-bw0-f47.google.com with SMTP id 10so2615068bwz.20
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 03:35:20 -0800 (PST)
In-Reply-To: <4D5CFA13.7030608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

Hi Archit,
 Those control registers are not a part of the mux list.
 So the mux framework does not support configuring them.
 Only the pad mux registers are configured.

Thanks,
 Sricharan


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of archit taneja
>Sent: Thursday, February 17, 2011 4:06 PM
>To: Benoit Cousson; linux-omap@vger.kernel.org
>Subject: OMAP4 Mux FW question
>
>Hi,
>
>Does the current Mux Framework support configuration of Registers like
>CONTROL_DSIPHY, CONTROL_USB etc in SYSCTRL_PADCONF_CORE in OMAP4? Could
>someone guide me to an example?
>
>Thanks,
>Archit
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
