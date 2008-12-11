From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Calling an I2C camera sensor with SMBUS API?
Date: Thu, 11 Dec 2008 17:58:23 -0600
Message-ID: <A24693684029E5489D1D202277BE894415E6E429@dlee02.ent.ti.com>
References: <200812111524.57050.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38429 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122AbYLKX6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 18:58:35 -0500
In-Reply-To: <200812111524.57050.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

> From: David Brownell [mailto:david-b@pacbell.net]
> On Thursday 11 December 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> > But one thing I noticed is that my sensor needs to access 16-bit
> > register addresses in the device, and I saw in SMBUS spec 2.0 that
> > the equivalent thing (SMBUS commands) are only 8-bit length.
> >
> > So, should this automatically discard using SMBUS api for my case,
> > or am I missing something else? (like a SMBUS 16-bit expansion or so)
> 
> There's the "proc call" which gives 16 bits in each direction;
> I think the Linux call for that got removed because it had no
> users, but could be restored if needed.
> 
> Probably best to take this question up on the I2C list.

Ok, thanks. Just did that. (with both of you guys on CC)

Regards,
Sergio
