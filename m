From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and OMAP4_KBD_SYSSTATUS
Date: Tue, 27 Nov 2012 10:47:41 +0530
Message-ID: <CAM=Q2cu_7gDvT57QhwbUpH1GQA7HgZ3j-sMbVq8UvYemO08TBA@mail.gmail.com>
References: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
	<20121126180158.GD14623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65531 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab2K0FRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 00:17:42 -0500
In-Reply-To: <20121126180158.GD14623@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

On Mon, Nov 26, 2012 at 11:31 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Nov 26, 2012 at 04:21:19PM +0530, Shubhrajyoti D wrote:
>> The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
>> so remove them.
>
> They document the existing registers and do not add bloat to the
> generated objects so let's leave them be.

The objective of the patch is not to prevent bloat.

Actually these registers have power/system impact so it was decided
that the drivers will not
configure the sysc registers (infact not define). Currently hwmod
configures the registers.

To be safe I thought of deleting it.


>
> Thanks.
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
