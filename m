From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
Date: Mon, 19 Dec 2011 17:01:14 -0600
Message-ID: <4EEFC23A.30201@gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46598 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab1LSXBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 18:01:18 -0500
Received: by yenm11 with SMTP id m11so3689638yen.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 15:01:17 -0800 (PST)
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/19/2011 08:05 AM, Aneesh V wrote:
> This is an RFC to add new device tree bindings for DDR memories and
> EMIF - TI's DDR SDRAM controller. 
> 
> The first patch adds bindings for DDR memories. Currently,
> we have added properties for only DDR3 and LPDDR2 memories.
> However, the binding can be easily extended to describe
> other types such as DDR2 in the future.
> 
> The second patch provides the bindings for the EMIF controller.
> 
> The final patch provides DT data for EMIF controller instances
> in OMAP4 and LPDDR2 memories attached to them on various boards.
> 
> Thanks to Rajendra for answering my numerous queries on device tree.
> 
> This is a re-post of the RFC that was posted to devicetree-discuss ml,
> now sent to a larger audience and looping out an internal list.
> Please ignore the previous version.

There's already a standard way (i.e. JEDEC standard) to define DDR chip
configuration that's called SPD. Why invent something new? While this is
normally an i2c eeprom on a DIMM, there's no reason you couldn't get it
from somewhere else including perhaps the DT. There's already code in
u-boot that can parse SPD data.

In general, is it really feasible to parse the DTB before DDR is
initialized?

Rob
