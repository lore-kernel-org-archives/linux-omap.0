From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
Date: Mon, 20 Feb 2012 10:04:05 +0200
Message-ID: <4F41FE75.4070003@ti.com>
References: <1329320246-1548-1-git-send-email-peter.ujfalusi@ti.com> <CANOLnONVm47DmMv8MdU1Y_Nx-387SZ5MBHwjO4cxkQ_caJ5dWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:58902 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995Ab2BTIED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Feb 2012 03:04:03 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so5965764lag.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 00:04:01 -0800 (PST)
In-Reply-To: <CANOLnONVm47DmMv8MdU1Y_Nx-387SZ5MBHwjO4cxkQ_caJ5dWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Hi Gra=C5=BEvydas,

On 02/18/2012 11:43 PM, Grazvydas Ignotas wrote:
> On Wed, Feb 15, 2012 at 5:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> Comments, testers are welcome...
>=20
> Tried these on current mainline and they break sound on pandora:
> # aplay /dev/urandom
> Playing raw data '/dev/urandom' : Unsigned 8 bit, Rate 8000 Hz, Mono
> [   81.306304] omap-mcbsp: clks: could not clk_set_parent() to pad_fc=
k
> [   81.313110] ASoC omap3pandora: can't set cpu system clock
> [   81.319244] asoc: machine hw_params failed
> aplay: set_params:1022: Unable to install hw params:
>=20
> I've retried without these patches to confirm it works like that, and=
 it did.

Thanks for testing the series.
The issue is that I forgot to remove the pm_runtime_put/get_sync calls
from the moved mcbsp.c file.
Can you manually remove these calls from sound/soc/omap/mcbsp.c ?
It will fix the issue I believe.
I will update the series.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
