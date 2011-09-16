From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform device driver
Date: Fri, 16 Sep 2011 15:00:18 +0530
Message-ID: <CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com>
	<20110915170548.GB2284@atomide.com>
	<CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45388 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751518Ab1IPJaV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 05:30:21 -0400
Received: by bkbzu17 with SMTP id zu17so4373757bkb.24
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 02:30:19 -0700 (PDT)
In-Reply-To: <CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

[...]
>>> 1. Modify the inline access functions to take the PEND and others
>>> =A0 =A0if needed registers as a parameter
>>>
>>> 2. Modify mach-omap2/timer.c to initialize the PEND and others
>>> =A0 =A0in the SoC specific timer_init function
Just to make my understanding complete, need some clarifications:
As we would end up modifying almost all inline functions, what naming
convention should we follow for the parameters? For instance, PEND
is related to TWPS register. So are you suggesting using parameter
names related to respective registers in each inline functions?
If that is the case we would end up declaring lot of local variables al=
ong
with PEND. Instead, we could very well have just two variables to
represent functional and interrupt offsets.

Also, in plat-omap/dmtimer.c, timer_regs{} stores the register values a=
nd
not the register offsets. Therefore, we would not be able to pass as
parameters, timer->context.<x> ... etc.

Please let me know if I am off-track in my understanding.
Thanks.
--
Tarun
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
