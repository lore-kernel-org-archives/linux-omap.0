From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Wed, 11 Apr 2012 10:57:18 -0500
Message-ID: <CAB-zwWhFTysfm4-7rY+g8rCOdRK6CAQA0c=+QaOyTxQOvVdLiw@mail.gmail.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
	<1323863746-18145-5-git-send-email-rnayak@ti.com>
	<CAB-zwWjSSsR0XMrntkEmHDtgJ_zDxgJh6KX=TsSKggd9mCgsVQ@mail.gmail.com>
	<4F85435C.1060305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:55976 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756672Ab2DKP5V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 11:57:21 -0400
Received: by lagu2 with SMTP id u2so1133393lag.21
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 08:57:18 -0700 (PDT)
In-Reply-To: <4F85435C.1060305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, tony@atomide.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

On Wed, Apr 11, 2012 at 3:39 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Yes, it is a known issue and the fix was unfortunately was not merged during
> -rc phases but is fixed in 3.4 and should be fixed in 3.3 stable branch as
> well. I received the notification from Greg KH 2 weeks ago about the stable:
> Patch "tty: serial: OMAP: Fix oops due to NULL pdata in DT boot" has been
> added to the 3.3-stable tree
>
> You should just switch to 3.4-rc2 or get the patch if you are stuck to 3.3.

Thanks, switching to 3.4-rc kernels fixed the problem (for cramfs),
and right now this works for me.

Regards,

Omar
