From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Mon, 14 Feb 2011 19:12:54 +0530
Message-ID: <b962d997079b52b8fed7d08af3a6842c@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
 <1295618465-15234-9-git-send-email-vishwanath.bs@ti.com> <AANLkTinKFYHLSZBMxukb7dT6tenozmVHBm6JR4FCSbak@mail.gmail.com>
 <0a4ab0bfef880f12edb62915a3592104@mail.gmail.com> <AANLkTikHGQvYf-YbWncp=qwH5bTpyDCTxeRByyy23VDE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50686 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754222Ab1BNNmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 08:42:55 -0500
Received: by mail-fx0-f47.google.com with SMTP id 17so5142755fxm.20
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 05:42:54 -0800 (PST)
In-Reply-To: <AANLkTikHGQvYf-YbWncp=qwH5bTpyDCTxeRByyy23VDE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Gery Kahn <geryk@ti.com>, linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

> -----Original Message-----
> From: Menon, Nishanth [mailto:nm@ti.com]
> Sent: Monday, February 14, 2011 6:33 PM
> To: Vishwanath Sripathy
> Cc: Gery Kahn; linux-omap@vger.kernel.org; patches@linaro.org;
> Santosh Shilimkar
> Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS
> support
>
> On Mon, Feb 14, 2011 at 18:19, Vishwanath Sripathy
> <vishwanath.bs@ti.com> wrote:
>
> >> Is there solution for the issue?
> > Yes this is an issue if CONFIG_SMP is disabled. We probably will need
> to
> > put this code under #ifdef CONFIG_SMP till lpj is handled for SMP in
> > generic cpufreq code itself .
> >
> Apologies, I am not clear, but how'd we handle the non smp case here?
For non SMP case, lpj is updated in common cpufreq code (in adjust_jiffies
function).

Vishwa
>
> Regards,
> Nishanth Menon
