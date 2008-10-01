From: "Jason Marini" <jason.marini@gmail.com>
Subject: Re: i2c errors on omap3430sdp
Date: Wed, 1 Oct 2008 10:22:29 -0400
Message-ID: <423644ca0810010722w340603fegf5443394a07b6f42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:48464 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYJAOWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 10:22:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so92737yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Oct 2008 07:22:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sergio,

Yes, that is what I have seen as well.  Although this specific
function returns -ETIMEDOUT, a function farther up the call stack must
be looping until success.

-Jason

> Jason, Felipe,
>
> Apparently it was a HW issue with the camkit I was using.
>
> I realized that when trying with another one :)
>
> Anyways, I appreciate your help and time.
>
> Jason, BTW, this messages kept appearing endlessly without being able to kill the \
> process, is that expected?
>
> Regards,
> Sergio
>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On \
>                Behalf Of Jason Marini
> Sent: Monday, September 29, 2008 11:18 AM
> To: linux-omap@vger.kernel.org
> Subject: Re: i2c errors on omap3430sdp
>
> > > Hi all,
> > >
> > > I'm currently testing the OV3640 CSI2 camera implementation for 3430SDP, and I \
> > > had \ it working some weeks ago.
> > > Today I did a git pull from the master branch.
> > >
> > > Without changing anything i2c related, I now sometimes get a message that I \
> > > wasn't \ getting before:
> > > i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
> > > i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
> > >
> > > Anyone is seeing this?
> > >
> > > Any omap i2c registration changes that I could be missing?
> >
> > Is you driver new style i2c driver ???
> >
> > Can you put some printks in your driver and try to narrow down which
> > transfer is triggering this timeout ??
> >
> > --
> > balbi
> > --
>
> Sergio,
>
> I recently added a patch to print out that message if the i2c bus took
> longer than 1s to poll for the i2c start condition.  I had been seeing
> kernel lockups when doing soft resets, and JTAG debug pointed me an
> infinite loop in the omap_i2c_read_reg function.  I added a timeout,
> as can be seen in my patch here:
> http://marc.info/?l=linux-omap&m=121995188317408&w=2
>
> You are seeing this message instead of a kernel hang :^)
>
> -Jason Marini
