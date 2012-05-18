From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 15:40:02 +0800
Message-ID: <CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
	<CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
	<CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39463 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759715Ab2ERHkG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 03:40:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SVHnA-0003G8-8Q
	for linux-omap@vger.kernel.org; Fri, 18 May 2012 07:40:04 +0000
Received: by dady13 with SMTP id y13so3493706dad.19
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 00:40:02 -0700 (PDT)
In-Reply-To: <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Hi,

On Fri, May 18, 2012 at 3:19 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> :
>>> Are you sure it fails ?

[    1.778930] GPMC revision 6.0
[    1.782226] gpmc: irq-52 could not claim: err -22


> Thanks for the reference. removing SHARED flag is not solution and
> yes, you might have to keep the dev-id if that was the issue.

Is the gpmc a shared interrupt line? SHARED is not needed at all for
non shared interrupt line in hardware.

Thanks,
--
Ming Lei
