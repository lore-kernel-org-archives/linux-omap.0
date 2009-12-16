From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: OMAP3 I2C driver timing problem with multiple messages transfer
Date: Wed, 16 Dec 2009 09:57:37 -0600
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202A9A04B66@dlee06.ent.ti.com>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
 <54B31811B83D744D90BF0289EB447D4609975E46F1@MAIL-MB1.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760027AbZLPP5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 10:57:46 -0500
In-Reply-To: <54B31811B83D744D90BF0289EB447D4609975E46F1@MAIL-MB1.oerlikon.ca>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Wending,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Weng, Wending
> Sent: Wednesday, December 16, 2009 8:54 AM
> To: linux-omap@vger.kernel.org; linux-i2c@vger.kernel.org
> Subject: OMAP3 I2C driver timing problem with multiple messages transfer
> 
> Hi All,
> 
>         Some I2C related protocols as SMBus, each command is composed of
> multiple I2C messages with timing constraint, the delay between two
> messages must be less than 10 ms, otherwise, the SMBus device will be
> timeout, and the command fails. As the function
> wait_for_completion_timeout is used to wait the end of a message, it
> doesn't guarante the next message will be sent out in 10 ms after the
> previous message is completed, so the SMBus command fails very often. I
> developped a patch for fixing this timing problem(2.6.32.RC5), is there
> anybody willing to review and to incorporate the patch into the furture
> release?
> 

Yes, do send out the patch as I am sure people would be interested to review your patch as well as incorporate it if it's needed. Please send out the patch to these mailing lists.

> Wending
> Software Engineer
> at Rheinmetall Canada
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
