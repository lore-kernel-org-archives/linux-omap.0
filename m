From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 05/10] OMAP4 : DSS2 : HDMI: HDMI driver addition in
 the DSS
Date: Thu, 10 Mar 2011 15:58:43 +0200
Message-ID: <1299765523.2017.192.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299753858-12222-2-git-send-email-mythripk@ti.com>
	 <1299753858-12222-3-git-send-email-mythripk@ti.com>
	 <1299753858-12222-4-git-send-email-mythripk@ti.com>
	 <1299753858-12222-5-git-send-email-mythripk@ti.com>
	 <1299753858-12222-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52307 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab1CJN6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:58:44 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2ADwihU009696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:58:44 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2ADwihY024640
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:58:44 -0600 (CST)
In-Reply-To: <1299753858-12222-6-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Adding the hdmi interface driver(hdmi.c) to the dss driver.
> It configures the audio and video portion of HDMI based on
> functionality called by the  panel driver.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
>                 Yong Zhi <y-zhi@ti.com>

This isn't the correct way to have signed off. Each person should be in
its own signed-off-by: line.

<snip>

> +/*
> + * Logic for the below structure :
> + * user enters the CEA or VESA timings by specifying the HDMI/DVI code.
> + * There is a correspondence between CEA/VESA timing and code , Please
> + * refer to section 6.3 in HDMI 1.3 specification for timing code.
> + * In the below structure, cea_vesa_timings corresponds to all OMAP4
> + * supported CEA and VESA timing values.
> + * code_cea corresponds to the CEA code , It is used to get the timing
> + * from cea_vesa_timing array. Similarly with code_vesa.
> + * code_index is used for back mapping, That is once EDID is read from
> + * the TV, EDID is parsed to find the timing values and then map it to
> + * corresponding CEA or VESA index.
> + */

This comment is still rather messy. Check capital letters, periods,
spaces before commas. Also, if you divide text into paragraphs, use an
empty line between the paragraphs. If you don't divide into paragraphs,
then the text should be evenly formatted.

 Tomi


