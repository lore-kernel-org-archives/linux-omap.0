From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP: ZOOM2: Change GPIO to enable LCD NEC NL8048HL11-01B
 on OMAP34x-II MDP
Date: Tue, 30 Nov 2010 17:33:26 -0600
Message-ID: <AANLkTi=skA_LhqLCYfUeubodLn4dY=_sC=R=Z3+-1nGk@mail.gmail.com>
References: <1290560402-2507-1-git-send-email-omar.ramirez@ti.com>
	<1290588435.13243.12.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51018 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180Ab0K3Xd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 18:33:27 -0500
Received: by mail-iw0-f177.google.com with SMTP id 4so540410iwn.8
        for <linux-omap@vger.kernel.org>; Tue, 30 Nov 2010 15:33:26 -0800 (PST)
In-Reply-To: <1290588435.13243.12.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yanick Saugy <yanick.saugy@heig-vd.ch>

On Wed, Nov 24, 2010 at 2:47 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2010-11-23 at 19:00 -0600, ext Omar Ramirez Luna wrote:
>> From: Yanick Saugy <yanick.saugy@heig-vd.ch>
>>
>> The PIN which controls LCD's reset signal (VGA_nRESET/h_GPIO_96) was not
>> configured as a GPIO. We had to modify the OMAP MUX, and select this PIN
>> (CAM_XCLKA) as an output GPIO (OMAP_MUX_MODE4). (kernel 2.6.35)
>>
>> Be aware of changing this PIN will probably disable the camera, because
>> it was previously configured as a camera clock.
>>
>> Signed-off-by: Yanick Saugy <yanick.saugy@heig-vd.ch>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>>
>> I'm not sure if this patch was forgotten, hence resending. Without
>> it, a blanks screen is seen on zoom2 board.
>
> Yes, I seem to have missed this.
>
> But I'm a bit confused. You say that this will disable camera. Is there
> a camera connected to the board, and it won't work after this?

I'm not quite familiar with the camera, but will try to check it
(might take some time).

Yes, there is a camera module connected to zoom2 board, but I don't
know for sure if both share this pin (which at least from author's
comment and existing code appears to be the case).

Regards,

Omar
