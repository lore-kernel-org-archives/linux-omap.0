From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH v2 1/9] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Thu, 22 Dec 2011 17:53:14 +0000
Message-ID: <CABS+qY3k6LJd6SWeVtrS3dXszpQy2nWpBm3dCq0WLLq+AZX_0w@mail.gmail.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
	<1324557768-8216-2-git-send-email-peter.ujfalusi@ti.com>
	<20111222130453.GQ4546@opensource.wolfsonmicro.com>
	<1324568573.4138.5.camel@odin>
	<20111222172838.GA29622@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41082 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753163Ab1LVRxQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:53:16 -0500
Received: by vbip1 with SMTP id p1so1991724vbi.18
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:53:14 -0800 (PST)
In-Reply-To: <20111222172838.GA29622@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 22 December 2011 17:28, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 22, 2011 at 03:42:53PM +0000, Liam Girdwood wrote:
>> On Thu, 2011-12-22 at 13:04 +0000, Mark Brown wrote:
>
>> > omap-abe-mcpdm-twl6040 please. =C2=A0Seriously, just drop the abe =
- it's not
>> > an optional feature of the OMAP and the names are getting quite lo=
ng.
>
>> ABE can be an optional feature on OMAP (and quite an important one w=
hen
>> it is used). Fwiw, we do have a mixture of users, most use the ABE b=
ut
>> some don't, so it's best to specify ABE in the naming to avoid any
>> confusion.
>
> Do you mean to say that there are OMAP4 variants that don't have the
> ABE or that some people choose not to do so for some reason, and unle=
ss
> the ABE might not be there shouldn't the driver just support both ABE
> and non-ABE paths anyway?

There nothing stopping drivers from using McBSP/McPDM etc directly
without the ABE as the do in OMAP3. Some people do this direct path
for specific drivers.

=C2=A0That's what the out of tree systems I've seen
> have done, though the main use of the non-ABE paths has always been
> confirming that issues are in the ABE.

Yep, we do sometimes add the "legacy" or direct DAI paths into ABE
mach drivers as well (but really just for debug purposes). These DAIs
are not used for any other audio use case except sometimes to debug.

Liam
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
