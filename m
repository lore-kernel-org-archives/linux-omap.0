From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: How to checkout v2.6.31-rc3 using git
Date: Wed, 15 Jul 2009 01:19:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58185 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113AbZGNTt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 15:49:29 -0400
In-Reply-To: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Users <linux-omap@vger.kernel.org>


Elvis
>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Elvis
>Dowson
>Sent: Tuesday, July 14, 2009 2:44 PM
>To: Linux OMAP Users
>Subject: How to checkout v2.6.31-rc3 using git
>
>Hi,
>	How should my git command look like if I were to try to check out
>v2.6.31-rc3 from the linux-omap-2.6 repository? I don't see a head for
>v2.6.31 , and the master branch is 2 weeks old at v2.6.31-rc1.

L-O seems to be still on v2.6.31-rc1
Use: $git tag -l 

Looks like tony has not synce'd up with rc2/3 yet.

If you need the new rc, then you could use kernel.org git.
Not sure what is your use case.

>
>Best regards,
>
>Elvis
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

