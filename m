From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [RFC 04/11] ASoC: core - Add API call to register dai kcontrols.
Date: Wed, 15 Feb 2012 17:52:37 +0200
Message-ID: <CAPo=G1zK9zB7ZEHa3_0ZfGsxFkqcvPcvQv4Nkjd3GFUwCYFTvg@mail.gmail.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
	<1329320280-1621-5-git-send-email-peter.ujfalusi@ti.com>
	<1329320781.14552.1.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46599 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751433Ab2BOPwi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:52:38 -0500
Received: by mail-yw0-f48.google.com with SMTP id j52so885997yhj.35
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:52:37 -0800 (PST)
In-Reply-To: <1329320781.14552.1.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Feb 15, 2012 at 5:46 PM, Liam Girdwood <lrg@ti.com> wrote:
> On Wed, 2012-02-15 at 17:37 +0200, Peter Ujfalusi wrote:
>> Allow dai drivers to register kcontrols.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> =A0include/sound/soc.h =A0| =A0 =A02 ++
>> =A0sound/soc/soc-core.c | =A0 31 +++++++++++++++++++++++++++++++
>> =A02 files changed, 33 insertions(+), 0 deletions(-)
>
> This feature has already been applied.

Oh, I'll take a look and use the existing feature.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
