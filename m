From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCHv2] OMAP3: CPUIdle: prevent CORE from going off if doing so
 would reset an active clockdomain
Date: Fri, 21 Jan 2011 15:34:55 +0530
Message-ID: <c18e60eda3b57ca0c69f7da8e0c34b38@mail.gmail.com>
References: <1295606225-11834-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60991 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827Ab1AUKLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 05:11:19 -0500
Received: by bwz12 with SMTP id 12so1420211bwz.13
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 02:11:17 -0800 (PST)
In-Reply-To: <1295606225-11834-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

> -----Original Message-----
> From: Tero Kristo [mailto:tero.kristo@nokia.com]
> Sent: Friday, January 21, 2011 4:07 PM
> To: linux-omap@vger.kernel.org
> Cc: Paul Walmsley; Kevin Hilman; Santosh Shilimkar; Vishwanath
> Sripathy
> Subject: [PATCHv2] OMAP3: CPUIdle: prevent CORE from going off if
> doing so would reset an active clockdomain
>
> On OMAP3 SoCs, if the CORE powerdomain enters off-mode, many other
> parts of the chip will be reset.  If those parts of the chip are
> busy,
> the reset will disrupt them, causing unpredictable and generally
> undesirable results. This reset is caused by the core domain wakeup
> (COREDOMAINWKUP_RST), and it can occur for example in a case where
> some peripheral domain is in retention or inactive state and core
> enters off. This will result in the peripheral domain being reset.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> ---
Thanks for update Tero.
If you like,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
