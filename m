From: "Kwangwoo Lee" <kwangwoo.lee@gmail.com>
Subject: Re: [PATCH] Add tsc2007 based touchscreen driver.
Date: Fri, 5 Dec 2008 10:09:29 +0900
Message-ID: <483a38b80812041709i10abeae4n571355dd1d88b6c2@mail.gmail.com>
References: <483a38b80812020539v2323a784h7f202749687764db@mail.gmail.com>
	 <483a38b80812032107i761fb9bdkba9b2ce5e998ae6a@mail.gmail.com>
	 <20081204093715.GH10209@gandalf.research.nokia.com>
	 <200812040156.55943.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:64699 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470AbYLEBJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 20:09:31 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3590041muf.1
        for <linux-omap@vger.kernel.org>; Thu, 04 Dec 2008 17:09:30 -0800 (PST)
In-Reply-To: <200812040156.55943.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com
Cc: ext Trilok Soni <soni.trilok@gmail.com>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thu, Dec 4, 2008 at 6:56 PM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 04 December 2008, Felipe Balbi wrote:
>> i2c subsystem has smbus emulation. The special reason is just that it's
>> simpler for the driver writer ;-)
>
> I'd have said "more portable", actually.  I2C hosts can
> do pretty much everything an SMBus host can, but the
> converse is not true.
>
> And re i2c_check_functionality() ... yes, use it to make
> sure each I2C or SMBus call the driver makes is supported
> by the underlying controller.
>

Thank you Brownell and Balbi.
Your comments are very helpful for me. I'll fix some part of the
driver and send it again later.

-- 
Kwangwoo Lee <kwangwoo.lee@gmail.com>
