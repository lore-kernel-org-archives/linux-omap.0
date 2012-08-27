From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v6 00/10] OMAP-GPMC: generic time calc, prepare for driver
Date: Mon, 27 Aug 2012 14:16:17 +0200
Message-ID: <503B6511.4050909@gmail.com>
References: <cover.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48292 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab2H0MQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 08:16:25 -0400
Received: by bkwj10 with SMTP id j10so1203626bkw.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 05:16:23 -0700 (PDT)
In-Reply-To: <cover.1345524670.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, jon-hunter@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 21.08.2012 12:41, Afzal Mohammed wrote:
> This series provides a generic gpmc timing calculation routine. There
> were three peripherals (OneNAND, tusb6010, smc91x) using custom timing
> calculations, they are migrated to use the generic timing calculation.
> 
> Such a generic routine would help create a driver out of gpmc platform
> code, which would be peripheral agnostic and thus lead to DT finally.
> Input to generic timing calculation routine would be gpmc peripheral
> timings, output - translated timings that gpmc can understand. Later,
> to DT'ify, gpmc peripheral timings could be passed through DT. Input
> timings that has been used here are selected such that it represents
> those that are present in peripheral timing datasheets.

What I don't understand yet about this new approach is where the gpmc
client code should live in. In order to probe the drivers via DT, each
driver would need to call the gpmc support functions itself, right? Is
the plan to obsolete helper functions like gpmc_nand_init() and move
that functionality to the drivers?

I applied these patches locally and would like to help get the NAND
controller on my AX33xx DT-driven board going. Let me know if I can do
anything here.


Regards,
Daniel

