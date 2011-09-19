From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv8] 00/16] OMAP PRCM chain handler driver
Date: Mon, 19 Sep 2011 19:20:47 +0530
Message-ID: <CAAL8m4yx-1HcN5UhQH7JscBthVYXtZEM5dgAEnCFzZ+DLdF0bQ@mail.gmail.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34697 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083Ab1ISNvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 09:51:08 -0400
Received: by bkbzt4 with SMTP id zt4so5308441bkb.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Sep 2011 06:51:07 -0700 (PDT)
In-Reply-To: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm@lists.arm.linux.org.uk

On Fri, Sep 16, 2011 at 9:35 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Hello,
>
> This patch set is the version 8 for the OMAP PRCM chain interrupt han=
dler.
> The driver is providing a chain handler for PRCM interrupt events, wh=
ich
> can be then individually used by different drivers. Currently PRCM in=
terrupt
> is owned by the PM core code and it is impossible for other users to =
listen
> to any of the PRCM events. Quite a few of the patches in this set are=
 tagged
> as TEMP, they are not meant for integration at this point, but are pr=
ovided
> as FYI for educated users and as a means to test the driver out.
>
> Changes compared to the previous set:
>
> - PRCM chain handler is now a driver of its own
> - The driver gets PRCM IP info from omap hwmod and configures itself =
based
> =A0on this
> - Added temporary implementations for OMAP3 and OMAP4 PRM hwmods
>
> Applies on top of Kevin's PM branch.
>
> Testing done:
>
> - platforms used: omap3 beagleboard and omap4430 blaze
> - suspend / resume test with retention : ok on both
> - cpuidle with retention test : ok on both
> - off-mode testing : ok on omap3 (omap4 does not support off-mode yet=
)
>
> OMAP4 testing was done on top of a custom kernel tree, this patch set
> does not work directly for omap4 on mainline.
>


Looks like you have CC'ed the wrong arm mailing list.

I think it should be be linux-arm-kernel@lists.infradead.org

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
