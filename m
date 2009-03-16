From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: I have some questions about DSS.
Date: Mon, 16 Mar 2009 09:23:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C522A4@dbde02.ent.ti.com>
References: <90b950fc0903142358o398d7f6bo159ee539664cb682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbZCPDxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 23:53:49 -0400
In-Reply-To: <90b950fc0903142358o398d7f6bo159ee539664cb682@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: InKi Dae <daeinki@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath
________________________________________
From: InKi Dae [mailto:daeinki@gmail.com] 
Sent: Sunday, March 15, 2009 12:28 PM
To: Hiremath, Vaibhav
Cc: linux-omap@vger.kernel.org
Subject: I have some questions about DSS.

I am trying to draw 720P streamming images decoded on LCD.
I really wonder about that.
In case of OMAP34XX, only video1 and video2 layer support color space conversion, scaling, rotation.
I think that ways using these features are like below.

[Hiremath, Vaibhav] Rotation is independent on plane, we are supporting rotation through VRFB.

1. Application -> video1 or 2 device node -> V4L2 Interface -> DSS Library -> LCD Panel or Digital output.
2. Application -> fb1 or 2 device node -> omafb driver -> DSS Library -> LCD Panel or Digital output.

[Hiremath, Vaibhav] Both the methods are working fine, at-least I have tested both.

Are all of the 1 and 2 case possible to draw 720P streamming images on LCD Panel in real-time ?
If the case of 1 is impossible, why impossible, and what is the reason implementing like case 2 ?
If possible, What is the way better ?

[Hiremath, Vaibhav]For streaming kind of application I would suggest you to use V4L2 framework.

Could you please tell me you know and you think ?
Thank you,
- InKi -
