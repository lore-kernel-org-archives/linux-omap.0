From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
Date: Mon, 20 Feb 2012 22:35:38 +0200
Message-ID: <CANOLnOM9nJ-ukM6z6w7uv8obSc+JO-0EbcSotwNKqW6o7tZNCA@mail.gmail.com>
References: <1329320246-1548-1-git-send-email-peter.ujfalusi@ti.com>
	<CANOLnONVm47DmMv8MdU1Y_Nx-387SZ5MBHwjO4cxkQ_caJ5dWA@mail.gmail.com>
	<4F41FE75.4070003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63061 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab2BTUfi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 15:35:38 -0500
Received: by iacb35 with SMTP id b35so7939758iac.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 12:35:38 -0800 (PST)
In-Reply-To: <4F41FE75.4070003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Feb 20, 2012 at 10:04 AM, Peter Ujfalusi <peter.ujfalusi@ti.com=
> wrote:
> Hi Gra=C5=BEvydas,
>
> On 02/18/2012 11:43 PM, Grazvydas Ignotas wrote:
>> On Wed, Feb 15, 2012 at 5:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.c=
om> wrote:
>>> Comments, testers are welcome...
>>
>> Tried these on current mainline and they break sound on pandora:
>> # aplay /dev/urandom
>> Playing raw data '/dev/urandom' : Unsigned 8 bit, Rate 8000 Hz, Mono
>> [ =C2=A0 81.306304] omap-mcbsp: clks: could not clk_set_parent() to =
pad_fck
>> [ =C2=A0 81.313110] ASoC omap3pandora: can't set cpu system clock
>> [ =C2=A0 81.319244] asoc: machine hw_params failed
>> aplay: set_params:1022: Unable to install hw params:
>>
>> I've retried without these patches to confirm it works like that, an=
d it did.
>
> Thanks for testing the series.
> The issue is that I forgot to remove the pm_runtime_put/get_sync call=
s
> from the moved mcbsp.c file.
> Can you manually remove these calls from sound/soc/omap/mcbsp.c ?
> It will fix the issue I believe.

Yup that helped, playback and recording on OMAP3 pandora
Tested-by: Grazvydas Ignotas <notasas@gmail.com>


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
