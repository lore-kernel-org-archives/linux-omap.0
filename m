From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: AM33xx's PWM Time Base Clock Enable signals
Date: Wed, 20 Feb 2013 12:54:46 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED2CC04@DBDE01.ent.ti.com>
References: <20130220123624.GA16652@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935088Ab3BTMyu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 07:54:50 -0500
In-Reply-To: <20130220123624.GA16652@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Philip, Avinash" <avinashphilip@ti.com>

+Avinash

On Wed, Feb 20, 2013 at 18:06:24, Balbi, Felipe wrote:
> Hi Paul, Tony,
> 
> how do you guys want to handle PWM's Time Base clocks which are enabled
> via control module ?
> 
> They're controlled via offset 0x664 (pwmss_ctrl). Page 793 of AM33xx's
> TRM has more information:
> 

Avinash has already posted the patch for this https://lkml.org/lkml/2013/2/12/43

Regards,
Vaibhav
