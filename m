From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Overo broken with current top of tree
Date: Thu, 30 Apr 2009 10:50:00 -0700
Message-ID: <5e088bd90904301050k7d088e50l9451097c8c15ac13@mail.gmail.com>
References: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com>
	 <20090430101619.GE10190@sirena.org.uk>
	 <5e088bd90904300807r2ddecfb3vd3f16ae8d2bfb4ce@mail.gmail.com>
	 <200904301041.13236.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:47682 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933934AbZD3RuB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 13:50:01 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1652617qwd.37
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2009 10:50:01 -0700 (PDT)
In-Reply-To: <200904301041.13236.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 30, 2009 at 10:41 AM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 30 April 2009, Steve Sakoman wrote:
>> The platform data messages still appear,
>
> Those platform_data patches are getting reverted.
> Ignore the messages for now.
>

Will do :-)  There seem to be no ill side effects, so it seems safe to do so.

I've also noticed that I now get occasional "mmcblk0: retrying using
single block read" messages on the serial console.  I haven't seen
these before.  Anyone see anything similar on their setup?

Steve
