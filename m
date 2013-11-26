From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/12] ARM: OMAP2+: Remove legacy PM init
Date: Tue, 26 Nov 2013 16:13:53 -0600
Message-ID: <CAGo_u6pwOdizyxD8Hy_znQHG0Spk-UTOKYxfj30UMxi7=cUbtw@mail.gmail.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
	<1385424867-27243-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:65443 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab3KZWNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 17:13:54 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so4123460wgh.17
        for <linux-omap@vger.kernel.org>; Tue, 26 Nov 2013 14:13:53 -0800 (PST)
In-Reply-To: <1385424867-27243-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Nov 25, 2013 at 6:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> This is no longer needed when booted with device tree.
[...]
>  static inline void omap_init_cpufreq(void)
>  {
>         struct platform_device_info devinfo = { };
>
> -       if (!of_have_populated_dt())
> -               devinfo.name = "omap-cpufreq";
> -       else
> -               devinfo.name = "cpufreq-cpu0";
> +       devinfo.name = "cpufreq-cpu0";

struct platform_device_info devinfo = { .name = "cpufreq-cpu0" };

otherwise, ok with the change.
Thanks and Regards,
Nishanth Menon
