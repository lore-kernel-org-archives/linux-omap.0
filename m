From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/8] arm: omap: add sdram-nokia.h
Date: Thu, 09 Dec 2010 10:45:27 -0600
Message-ID: <4D0107A7.80900@ti.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com> <1291912764-12823-3-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42261 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753902Ab0LIQpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 11:45:32 -0500
Received: by mail-vw0-f52.google.com with SMTP id 13so1767412vws.25
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 08:45:31 -0800 (PST)
In-Reply-To: <1291912764-12823-3-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Aaro Koskinen had written, on 12/09/2010 10:39 AM, the following:
[...]
> diff --git a/arch/arm/mach-omap2/sdram-nokia.h b/arch/arm/mach-omap2/sdram-nokia.h
> new file mode 100644
> index 0000000..ee63da5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sdram-nokia.h
> @@ -0,0 +1,12 @@
> +/*
> + * SDRC register values for Nokia boards
> + *
> + * Copyright (C) 2010 Nokia
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +struct omap_sdrc_params *nokia_get_sdram_timings(void);
> +
Minor comment: Header guard missing. maybe nice to add #ifndef, #def, 
#endif.

Regards,
Nishanth Menon
