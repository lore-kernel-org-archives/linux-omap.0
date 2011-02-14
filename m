From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Mon, 14 Feb 2011 18:33:18 +0530
Message-ID: <AANLkTikHGQvYf-YbWncp=qwH5bTpyDCTxeRByyy23VDE@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
 <1295618465-15234-9-git-send-email-vishwanath.bs@ti.com> <AANLkTinKFYHLSZBMxukb7dT6tenozmVHBm6JR4FCSbak@mail.gmail.com>
 <0a4ab0bfef880f12edb62915a3592104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56369 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753415Ab1BNNDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 08:03:41 -0500
Received: by mail-ey0-f179.google.com with SMTP id 24so2322172eyg.24
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 05:03:39 -0800 (PST)
In-Reply-To: <0a4ab0bfef880f12edb62915a3592104@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Gery Kahn <geryk@ti.com>, linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, Feb 14, 2011 at 18:19, Vishwanath Sripathy <vishwanath.bs@ti.com> wrote:

>> Is there solution for the issue?
> Yes this is an issue if CONFIG_SMP is disabled. We probably will need to
> put this code under #ifdef CONFIG_SMP till lpj is handled for SMP in
> generic cpufreq code itself .
>
Apologies, I am not clear, but how'd we handle the non smp case here?

Regards,
Nishanth Menon
