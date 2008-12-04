From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Add tsc2007 based touchscreen driver.
Date: Thu, 4 Dec 2008 11:37:15 +0200
Message-ID: <20081204093715.GH10209@gandalf.research.nokia.com>
References: <483a38b80812020539v2323a784h7f202749687764db@mail.gmail.com> <5d5443650812030321p77c4941cj2202418f0b0d44a2@mail.gmail.com> <20081203120144.GA10123@gandalf.research.nokia.com> <483a38b80812032107i761fb9bdkba9b2ce5e998ae6a@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20694 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYLDJh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 04:37:57 -0500
Content-Disposition: inline
In-Reply-To: <483a38b80812032107i761fb9bdkba9b2ce5e998ae6a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: felipe.balbi@nokia.com, ext Trilok Soni <soni.trilok@gmail.com>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thu, Dec 04, 2008 at 02:07:30PM +0900, ext Kwangwoo Lee wrote:
> Because the platform which I use did not implement smbus_xfer yet,
> it only implemented  master_xfer in struct i2c_algorithm.
> I can add smbus_xfer for my platform. I have one question and
> I know that smbus is a subset from the I2C protocol.
> Is smbus_xfer method better than master_xfer or is there any
> special reason to use smbus_xfer?

i2c subsystem has smbus emulation. The special reason is just that it's
simpler for the driver writer ;-)

-- 
balbi
