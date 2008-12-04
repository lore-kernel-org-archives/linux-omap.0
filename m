From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Add tsc2007 based touchscreen driver.
Date: Thu, 4 Dec 2008 01:56:54 -0800
Message-ID: <200812040156.55943.david-b@pacbell.net>
References: <483a38b80812020539v2323a784h7f202749687764db@mail.gmail.com> <483a38b80812032107i761fb9bdkba9b2ce5e998ae6a@mail.gmail.com> <20081204093715.GH10209@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:46754 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750895AbYLDJ46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 04:56:58 -0500
In-Reply-To: <20081204093715.GH10209@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, ext Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: ext Trilok Soni <soni.trilok@gmail.com>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thursday 04 December 2008, Felipe Balbi wrote:
> i2c subsystem has smbus emulation. The special reason is just that it's
> simpler for the driver writer ;-)

I'd have said "more portable", actually.  I2C hosts can
do pretty much everything an SMBus host can, but the
converse is not true.

And re i2c_check_functionality() ... yes, use it to make
sure each I2C or SMBus call the driver makes is supported
by the underlying controller.

- Dave

