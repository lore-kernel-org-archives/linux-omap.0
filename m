From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Merge plans for 2.6.33 merge window
Date: Thu, 3 Dec 2009 23:58:33 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54F@dbde02.ent.ti.com>
References: <20091203173559.GR4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755606AbZLCS2g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 13:28:36 -0500
In-Reply-To: <20091203173559.GR4348@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>Lindgren
>Sent: Thursday, December 03, 2009 11:36 AM
>To: linux-omap@vger.kernel.org
>Subject: Merge plans for 2.6.33 merge window
>
>Hi all,
<snip>
>Then there are some new board files, like
>touchbook and various fixes.

3630 board support (zoom3/sdp3630) is already integrated in for-next.
However the only pending patches missing for 3630 boards to boot are these serial patches:
	http://patchwork.kernel.org/patch/61671/
	http://patchwork.kernel.org/patch/61672/

Now there has been much discussion on the approach (errata vs feature).
As a moderator, how would you like us to proceed on this?

Regards,
Vikram

