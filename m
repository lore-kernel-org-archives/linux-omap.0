From: Grazvydas Ignotas <notasas@gmail.com>
Subject: ASoC related suspend problems on OMAP3
Date: Wed, 8 Feb 2012 02:34:38 +0200
Message-ID: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63908 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841Ab2BHAej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 19:34:39 -0500
Received: by iacb35 with SMTP id b35so18573iac.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 16:34:39 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

Hi,

On OMAP3 pandora, system suspend stops working properly after using
audio at least once:

(just after boot):
# echo mem > /sys/power/state
[   12.578186] PM: Entering mem sleep
[   12.678802] PM: suspend of devices complete after 92.834 msecs
[   12.688201] PM: late suspend of devices complete after 3.173 msecs
[   17.607971] Successfully put all powerdomains to target state

# aplay /dev/zero
^C
# echo mem > /sys/power/state
[  104.404663] PM: suspend of devices complete after 78.794 msecs
[  104.413909] PM: late suspend of devices complete after 3.021 msecs
[  106.601196] Powerdomain (per_pwrdm) didn't enter target state 1
[  106.607421] Powerdomain (core_pwrdm) didn't enter target state 1
[  106.613739] Could not enter target state in pm_suspend

I'm seeing this on 3.2, unable to verify on current Linus HEAD as
something else is preventing core/per low power states there.
Any ideas what could be causing this? Perhaps some clock is left enable=
d?

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
