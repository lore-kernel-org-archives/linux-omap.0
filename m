From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
Date: Sat, 20 Nov 2010 15:38:42 +0530
Message-ID: <fc42ca6f03504dea078f111b3ef03a4a@mail.gmail.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com><1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
 <yw1xfwux411g.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38464 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895Ab0KTKIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Nov 2010 05:08:45 -0500
Received: by vws7 with SMTP id 7so524916vws.31
        for <linux-omap@vger.kernel.org>; Sat, 20 Nov 2010 02:08:44 -0800 (PST)
In-Reply-To: <yw1xfwux411g.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, tony@atomide.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: M=E5ns Rullg=E5rd [mailto:mans@mansr.com]
> Sent: Saturday, November 20, 2010 12:02 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; nm@ti.com; mans@mansr.com;
> tony@atomide.com; khilman@deeprootsystems.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The AXI protocol specifies that the write response can only
> > be sent back to an AXI master when the last write data has been
> > accepted. This optimization enables the PL310 to send the write
> > response of certain write transactions as soon as the store buffer
> > accepts the write address. This behavior is not compatible with
> > the AXI protocol and is disabled by default. You enable this
> > optimization by setting the Early BRESP Enable bit in the
> > Auxiliary Control Register (bit [30]).
>
> Did you measure the performance difference this makes, if any?
>
I didn't do any special runs for this bit alone. Just checked
with hardware team and they confirmed that you would gain a bit
on writes and it's good to enable it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
