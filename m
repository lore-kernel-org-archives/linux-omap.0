From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH V3 2/2]OMAP: Disable internal I2C pull-ups in OMAP3630
Date: Wed, 9 Jun 2010 21:26:24 +0200
Message-ID: <AANLkTimwvegsWDtS7v-aZmjCHyl46ATcgo5wGWCm3xn-@mail.gmail.com>
References: <1267211687-23551-1-git-send-email-m-sonasath@ti.com>
	<CD8CC2B65FEE304DA95744A5472698F202D3F744A2@dlee06.ent.ti.com>
	<20100608100437.GP15515@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39842 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab0FIT01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 15:26:27 -0400
Received: by wyb40 with SMTP id 40so439567wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Jun 2010 12:26:25 -0700 (PDT)
In-Reply-To: <20100608100437.GP15515@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Tony,

On Tue, Jun 8, 2010 at 12:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> Because of this, 3630 boards should have the mux register pull-ups disabled,
> and only use the dedicated I2C pull-ups. In theory external pull-ups should
> not be needed. The value configured for the dedicated I2C pull-ups depends
> on the connected I2C device, and the number of devices.
>
If the internal pull-ups are disabled, why are external pull-ups not needed?

Regards,
-- 
Leon
