From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
Date: Mon, 13 Dec 2010 12:28:24 -0600
Message-ID: <AANLkTi=HvDiirrfXMXmzZkrm6NwAdZJQERs5F86Jj6TG@mail.gmail.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
	<1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49989 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751228Ab0LMS2Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 13:28:24 -0500
Received: by mail-pz0-f44.google.com with SMTP id 5so578013pzk.3
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 10:28:24 -0800 (PST)
In-Reply-To: <1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> - =A0 =A0 =A0 mbox_ick_handle =3D clk_get(NULL, "mailboxes_ick");
> - =A0 =A0 =A0 if (IS_ERR(mbox_ick_handle)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not get mailboxe=
s_ick: %ld\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PTR_ERR(mbox_ick_handle=
));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(mbox_ick_handle);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 clk_enable(mbox_ick_handle);
> + =A0 =A0 =A0 pm_runtime_get_sync(&mbox_pdev->dev);

Might be good to check the return value.


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
