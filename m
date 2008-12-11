From: David Brownell <david-b@pacbell.net>
Subject: Re: Calling an I2C camera sensor with SMBUS API?
Date: Thu, 11 Dec 2008 15:24:56 -0800
Message-ID: <200812111524.57050.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:23363 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756752AbYLKXZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2008 18:25:00 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Thursday 11 December 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> But one thing I noticed is that my sensor needs to access 16-bit
> register addresses in the device, and I saw in SMBUS spec 2.0 that
> the equivalent thing (SMBUS commands) are only 8-bit length.  
> 
> So, should this automatically discard using SMBUS api for my case,
> or am I missing something else? (like a SMBUS 16-bit expansion or so) 

There's the "proc call" which gives 16 bits in each direction;
I think the Linux call for that got removed because it had no
users, but could be restored if needed.

Probably best to take this question up on the I2C list.

- Dave



