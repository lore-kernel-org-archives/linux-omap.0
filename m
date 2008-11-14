From: twebb <taliaferro62@gmail.com>
Subject: Re: DVI output support for OMAP35x EVM
Date: Fri, 14 Nov 2008 17:01:20 -0500
Message-ID: <dbdb2ea60811141401l1ba052d4s26b726e461c17ac5@mail.gmail.com>
References: <dbdb2ea60811120936h971a955t956726dd7f8db22d@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403E5F2B197@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:34398 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYKNWBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 17:01:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so784855wah.21
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 14:01:20 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E5F2B197@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

>> The SDK 1.0.0 kernel for OMAP35x EVM from TI included DVI support
>> (480P and 720P) in the display driver.  Is there a patch that was
>> submitted to the l-o git that includes that support?  I'm looking to
>> add DVI support into the kernel I'm currently using, which is
>> linux-omap-2.6 (tag = v2.6.27-omap1).
>>
> [Hiremath, Vaibhav] The l-o version of kernel doesn't support most of the features supported in SDK 1.0.0. We are working towards it. Below is link which will help you to understand where we are heading -
>
> http://markmail.org/message/p3aktfdgoumeludd#query:vaibhav%20DSS%20lib+page:1+mid:nzjsnawvnmtqjfwa+state:results
>

I'm not very familiar with the video and graphics subsystems, but was
just looking for code that supported output on the DVI connector.  So
is the RFC by Hardik Shah at this link...
http://lists-archives.org/video4linux/23648-omap3-display-driver-v4l2.html
the best description of where TI is headed?  And is code  based on
this only available in omapzoom git?  Also, I don't see mention of the
DVI support in the RFC - am I missing something?

Thanks,
twebb
