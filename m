From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC 2/9] opp-modifier: Add opp-modifier-reg driver
Date: Fri, 14 Mar 2014 16:00:06 -0500
Message-ID: <CAL_Jsq+BzJeaiPwJsH5bFmtsxCPOspEjnmMLdAVyLAriQTF+kw@mail.gmail.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
	<1394825135-60110-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:59865 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbaCNVAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 17:00:07 -0400
In-Reply-To: <1394825135-60110-3-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>

On Fri, Mar 14, 2014 at 2:25 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Driver to read from a register and depending on either set bits or
> a specific known selectively enable or disable OPPs based on DT node.
>
> Can support opp-modifier-reg-bit where single bits within the register
> determine the availability of an OPP or opp-modifier-reg-val where a
> certain value inside the register or a portion of it determine what the
> maximum allowed OPP is.
>
> The driver expects a device that has already has its OPPs loaded
> and then will disable the OPPs not matching the criteria specified in
> the opp-modifier table.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/power/opp-modifier.txt     | 111 +++++++++
>  drivers/power/opp/Makefile                         |   1 +
>  drivers/power/opp/opp-modifier-reg.c               | 259 +++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/opp-modifier.txt
>  create mode 100644 drivers/power/opp/opp-modifier-reg.c
>
> diff --git a/Documentation/devicetree/bindings/power/opp-modifier.txt b/Documentation/devicetree/bindings/power/opp-modifier.txt
> new file mode 100644
> index 0000000..af8a2e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/opp-modifier.txt
> @@ -0,0 +1,111 @@
> +* OPP-Modifier - opp modifier to selectively enable operating points
> +
> +Many SoCs that have selectively modifiable OPPs can specify
> +all available OPPs in their operating-points listing and then define
> +opp_modifiers to enable or disable the OPPs that are actually available
> +on the specific hardware.
> +
> +* OPP Modifier Provider

Uggg. Please stop designing around the current OPP binding which has
the problem that the OPP table is not extensible to add more data.
Define a new OPP binding that solves these problems. This is at least
the 3rd OPP related binding addition I've seen recently. But I
wouldn't spend a lot of effort on a new OPP binding just to add the
functionality you are adding here because I don't like the whole
concept in general. This might be a common way to determine valid OPPs
on TI chips, but I think it is too low level and I don't want to see
bindings for every different possible way. Just add platform code to
do the OPP setup you need.

Frankly, I prefer the bootloader/firmware fixup the OPP table approach
mentioned in the cpufreq-cpu0 thread. Somewhat less desirable, but the
kernel could do the fixups as well (via of_update_property).

Rob
