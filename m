From: "Titiano, Patrick" <p-titiano@ti.com>
Subject: RE: [PATCH/RFC 2/4] OMAP2: PM debug: remove register dumping
Date: Tue, 31 May 2011 10:24:10 +0200
Message-ID: <E8606C3FD412994585953171ED63A9340219136F97@dnce01.ent.ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com><1306450971-27732-3-git-send-email-khilman@ti.com>
 <BANLkTikG1yExnfKGH6RsXU99MfTxGgiXww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46298 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100Ab1EaIYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 04:24:13 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTikG1yExnfKGH6RsXU99MfTxGgiXww@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Monday, May 30, 2011 10:05 AM
> To: Hilman, Kevin
> Cc: linux-omap@vger.kernel.org; Titiano, Patrick
> Subject: Re: [PATCH/RFC 2/4] OMAP2: PM debug: remove register dumping
>
> On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm-debug.c |  119 ---------------------------------
> -------
> >  arch/arm/mach-omap2/pm.h       |    4 -
> >  arch/arm/mach-omap2/pm24xx.c   |    6 +-
> >  3 files changed, 2 insertions(+), 127 deletions(-)
> >
> ...
>
> OK for this change. Is it the intention to use the omapconf tool as
> the replacement for the regs dump code?

Sorry but omapconf is run from userspace, it cannot be used to dump PRCM registers right before and after MPU WFI.

Regards,
Patrick.


>
> Acked-by: Jean Pihet <j-pihet@ti.com>
>
> Regards,
> Jean

