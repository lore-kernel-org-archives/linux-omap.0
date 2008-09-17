From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 09:18:40 +0300
Message-ID: <57314e840809162318qa301e07tbf92b518ed4cc1e8@mail.gmail.com>
References: <87tzcgi1gv.fsf@nokia.com>
	 <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com>
	 <20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:65027 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYIQGSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 02:18:41 -0400
Received: by py-out-1112.google.com with SMTP id p76so2288719pyb.10
        for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 23:18:41 -0700 (PDT)
In-Reply-To: <20080916232505.GC25885@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, Kalle Valo <kalle.valo@nokia.com>, linux-omap@vger.kernel.org

On Wed, Sep 17, 2008 at 2:25 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hopefully we'll get all core 24xx and 34xx files integrated soon. But
> then there are tons of board-*.c files missing from mainline that
> probably need to be cleaned up a bit.

What about sending the board to standby via /sys/power/state and
waking it up via pressing one of the keypad buttons ? Is it already
supported in mainline ?
