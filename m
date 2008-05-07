From: "arun c" <arun.edarath@gmail.com>
Subject: Re: FrameBuffer Boot Option OMAP3 & 2
Date: Wed, 7 May 2008 09:46:03 +0530
Message-ID: <c656a4d20805062116j4aa3ccc9ud4fb54adace23ce1@mail.gmail.com>
References: <DF2E621E2E4C14428B271D6363D915C80118542E@dnce03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:33381 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbYEGEQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 00:16:07 -0400
Received: by po-out-1718.google.com with SMTP id y22so160860pof.1
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 21:16:04 -0700 (PDT)
In-Reply-To: <DF2E621E2E4C14428B271D6363D915C80118542E@dnce03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Royer, Fabien" <f-royer@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Fabien,

On Tue, May 6, 2008 at 9:37 PM, Royer, Fabien <f-royer@ti.com> wrote:
> Hello everyone,
>
>
>
>  I am working on the OMAP3 board for displaying video Demos.
>
>
>
>  I am using Mplayer to play some video, but it is using the half of the
>  screen I would like the fullscreen.
>
>
>
>  I try to change in the bootargs omap24xxfb and to put the option
>  rotation 90.
>
>
>
>  So I enter in the U-boot console  # setenv video omap24xxfb:rotation=90
It is video=omap24xxfb:rotation=90
Why a separate variable 'video' ?, instead specify this in bootargs.

One more thing please don't forget to mention the kernel you
are using( I think you are using 2.6.14 kernel and not the latest git)

Regards,
Arun C
