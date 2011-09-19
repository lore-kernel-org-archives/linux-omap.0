From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH
 v15 06/12] OMAP: dmtimer: switch-over to platform device driver)
Date: Mon, 19 Sep 2011 10:43:53 -0700
Message-ID: <20110919174353.GG2937@atomide.com>
References: <1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
 <20110914214533.GA30941@atomide.com>
 <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
 <20110915165810.GA2284@atomide.com>
 <20110915170548.GB2284@atomide.com>
 <CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
 <CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
 <20110917013531.GB2937@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302575A0FBC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52042 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754480Ab1ISRnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 13:43:55 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302575A0FBC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

* Mohammed, Afzal <afzal@ti.com> [110918 21:48]:
> Hi Tony,
> 
> On Sat, Sep 17, 2011 at 07:05:31, Tony Lindgren wrote:
> > 
> > Afzal, care to check if that works for AM335X/TI816X/TI814X?
> 
> With following patch over yours, AM335X (the only board with me) boots up fine.

Thanks for catching that, will fold it in with your Signed-off-by.

Regards,

Tony
