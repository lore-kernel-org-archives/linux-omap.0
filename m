From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: doubt about adding entries in mux.c
Date: Tue, 10 Jun 2008 07:43:22 -0500
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0541D904@dlee11.ent.ti.com>
References: <dfeb90390806100419r6510cc97xbd855a16e87d4209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbYFJMny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 08:43:54 -0400
Content-class: urn:content-classes:message
In-Reply-To: <dfeb90390806100419r6510cc97xbd855a16e87d4209@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>, linux-omap@vger.kernel.org

Arun,

	J15 is the ball on the BGA package that I2C2_SCL is assigned to
on the OMAP242x.
	The reason this may be important for some signals, is they may
actually have multiplexing options to come out on a number of different
balls.  The I2C2_SCL only comes out on J15, so it is redundant, but for
convention purposes, stating the ball is used.

Brandon Azbell 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Arun KS
Sent: Tuesday, June 10, 2008 6:19 AM
To: linux-omap@vger.kernel.org
Subject: doubt about adding entries in mux.c

Hi all,

  Is there any naming convention for adding the entry in mux.c?
I could'nt understand what this J15 signifies in the following name,
J15_24XX_I2C2_SCL, for example.
Could someone help me.

Best Regards,
Arun
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
