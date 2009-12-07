From: Tim Yamin <plasmaroo@gmail.com>
Subject: Re: [PATCH 2/8] Board file of Always Innovating OMAP3-based Touch
	Book
Date: Mon, 7 Dec 2009 22:11:12 +0000
Message-ID: <792f5f410912071411i5ebfec90n419a38ca4245e694@mail.gmail.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
	 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
	 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
	 <19F8576C6E063C45BE387C64729E739404370D6FAB@dbde02.ent.ti.com>
	 <20091207214907.GK24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:49382 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934388AbZLGWLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 17:11:07 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1248643eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Dec 2009 14:11:12 -0800 (PST)
In-Reply-To: <20091207214907.GK24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Gregoire Gentil <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/12/7 Tony Lindgren <tony@atomide.com>:
>> One more thing just came in my mind, have you thought of using standard backlight class driver???
>
> I'll add this without the backlight code so we get the basic
> support into mainline while using the backlight class driver
> issue is being discussed.

But the board file *is* implementing the standard backlight class,
i.e. the interface in linux/backlight.h... perhaps I'm
misunderstanding the intention here?

Tim
