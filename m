From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: OMAP Zoom kernel ALSA build problem
Date: Thu, 4 Dec 2008 23:21:27 +0530
Message-ID: <5d5443650812040951p33886dcchd04b11932641625b@mail.gmail.com>
References: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com>
	 <200812040940.18076.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:38703 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbYLDRv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 12:51:29 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1768269ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 04 Dec 2008 09:51:28 -0800 (PST)
In-Reply-To: <200812040940.18076.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Smith, Stephen" <smsmith@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Dec 4, 2008 at 11:10 PM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 04 December 2008, Smith, Stephen wrote:
>> I am trying to build sound support for the MDK (3430LDP).  There is a build
>> problem on the current git master of the OMAP Zoom kernel.
>
> Perhaps that kernel should sync with newer code?

This is going to happen on some other drivers in future too, because
for some unknown reasons (atleast I don't know), that OMAP Zoom went
ahead with their tree. I don't see any reason why they have to create
new tree. See, how beagleboard guys are working.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
