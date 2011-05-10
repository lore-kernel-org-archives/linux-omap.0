From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH v3 4/4] OMAP: DSS: Add picodlp panel driver
Date: Tue, 10 May 2011 14:14:29 +0300
Message-ID: <1305026069.2045.27.camel@deskari>
References: <1304954319-8386-1-git-send-email-mayur@ti.com>
	 <1304954319-8386-5-git-send-email-mayur@ti.com>
	 <1305020000.3237.16.camel@lappyti>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DB0868E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57212 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab1EJLOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 07:14:34 -0400
Received: by mail-ey0-f179.google.com with SMTP id 5so1944827eyg.10
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 04:14:32 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033DB0868E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-05-10 at 15:57 +0530, Janorkar, Mayuresh wrote:

> > It is better to request and initialize the GPIOs in the board file. The
> > reason for this is that the PicoDLP device should be off if it's not
> > used, or if the driver is not even compiled in. So the board file should
> > make sure that the GPIOs are in such state that the device is off.
> 
> The board file has only init. There is no exit.
> So if I request gpios in init once, I could not find a place to free them.

If the GPIOs are not shared, and they go only to picodlp, there's not
really any need to free them. They are not a shared resource, and they
can be kept reserved for picodlp all the time.

> Is it a good idea to request gpios in platform_enable and free them in platform_disable?

No, that wouldn't fix the problem.

For example, consider a case where the kernel is compiled without
picodlp driver. So platform_enable/disable is never called, and the
GPIOs are never requested or initialized. This means that depending on
the values of the GPIOs, the picodlp could be always on, consuming
power.

So my suggestion is to request all the GPIOs in the board file, in
display init, and initialize the GPIOs to some sane value so that the
picodlp is off. Then pass the two GPIOs to the picodlp driver, which can
then use the GPIOs, and handle the two other GPIOs in the board file in
platform_enable/disable. 

 Tomi


