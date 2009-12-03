From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: u-boot for omap3
Date: Fri, 4 Dec 2009 00:10:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C551@dbde02.ent.ti.com>
References: <54B31811B83D744D90BF0289EB447D46099619D83F@MAIL-MB1.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34955 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbZLCSka convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 13:40:30 -0500
In-Reply-To: <54B31811B83D744D90BF0289EB447D46099619D83F@MAIL-MB1.oerlikon.ca>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom <Tom.Rix@windriver.com>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Weng,
>Wending
>Sent: Thursday, December 03, 2009 12:32 PM
>To: linux-omap@vger.kernel.org
>Subject: u-boot for omap3
>
>Hi all,
>
>        Anybody knows who takes care of u-boot for omap3, I wish to fix a L2 cahe related bug if 

Tom Rix is the Arm u-boot maintainer. 
Omap3 falls as one of the silicon he maintains.

In reality, there are always internal/forked versions of the upstream that get used.
Like for zoom boards I maintain it at dev.omapzoom.org /bootloader/* 


it's
>not done yet.
>
>Regards
>Wending
>
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
