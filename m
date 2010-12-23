From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v1 00/10] OMAP: McBSP: hwmod adaptation and runtime conversion
Date: Thu, 23 Dec 2010 14:51:49 +0530
Message-ID: <AANLkTi=wX3fo7t2GLbbxHK3eFb+-r7HEZ839zT2nFjLX@mail.gmail.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com> <1292917231-13800-11-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37999 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752233Ab0LWJW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 04:22:56 -0500
Received: by mail-iw0-f169.google.com with SMTP id 40so6634859iwn.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 01:22:55 -0800 (PST)
In-Reply-To: <1292917231-13800-11-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com

Kishon,

On Tue, Dec 21, 2010 at 13:10, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime APIs.

This patch series should also delete the macros like
"OMAP*_MCBSP*_BASE" once the driver
starts using hwmod framework because such information can be extracted
from hwmod database.

>
> Created on top of linux OMAP master (linux-omap-2.6 :master)
> Tested on OMAP4430 and OMAP3430 SDP boards. Verified that this patch
> series does not break the OMAP1 build.

-V Charulatha
