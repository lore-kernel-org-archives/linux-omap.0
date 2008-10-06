From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: Current git head oops'es at boot on Overo
Date: Mon, 6 Oct 2008 14:57:22 -0700
Message-ID: <5e088bd90810061457k41ef44cax53dce310ce239315@mail.gmail.com>
References: <5e088bd90810061126g75ff7768k8fa768751a31e379@mail.gmail.com>
	 <200810061253.13997.david-b@pacbell.net>
	 <5e088bd90810061404r76001744w4bc094cbd98077f@mail.gmail.com>
	 <e5e6ade50810061415k60d77010x8f46be8835b6830d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48049 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYJFV5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 17:57:24 -0400
Received: by gxk9 with SMTP id 9so5691016gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 14:57:23 -0700 (PDT)
In-Reply-To: <e5e6ade50810061415k60d77010x8f46be8835b6830d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Mon, Oct 6, 2008 at 2:15 PM, Nathan Monson <nmonson@gmail.com> wrote:
> I'm set up as host, using a BeagleBoard, and with the current
> linux-omap git I can get USB working by unplugging and replugging the
> A side of the cable (at the mini-AB connector on the BeagleBoard).
>
> Just disconnecting the cable at the B side is not enough.  It must
> have something to do with the ID pin.  So, if you have a soldered ID
> pin it wouldn't work either.
>
> Also, my cable is going into a powered 4 port high speed hub.  That
> might make a difference.

Same here -- 4 port high speed hub, disconnect/reconnect cable at the
A (board) side.

No joy on Overo.

Steve
