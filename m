From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: Calling an I2C camera sensor with SMBUS API?
Date: Thu, 11 Dec 2008 17:10:21 -0600
Message-ID: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54650 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755569AbYLKXKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 18:10:32 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi,

Some days back, Vaibhav Hiremat submitted patches for an I2C chip, and somebody (I think David Brownell) suggested to use SMBUS API instead of manually constructing i2c messages and sending using i2c_transfer API.

So I attempted to do the same for a camera sensor I've been working on.

But one thing I noticed is that my sensor needs to access 16-bit register addresses in the device, and I saw in SMBUS spec 2.0 that the equivalent thing (SMBUS commands) are only 8-bit length.

So, should this automatically discard using SMBUS api for my case, or am I missing something else? (like a SMBUS 16-bit expansion or so)

Regards,
Sergio
