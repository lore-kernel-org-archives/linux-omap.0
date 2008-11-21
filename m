From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
Date: Fri, 21 Nov 2008 11:11:40 -0800
Message-ID: <200811211111.41038.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1227280923-31654-1-git-send-email-hvaibhav@ti.com> <5d5443650811211012t238dd191t81680c45717d8337@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:23843 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751107AbYKUTLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 14:11:44 -0500
In-Reply-To: <5d5443650811211012t238dd191t81680c45717d8337@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: hvaibhav@ti.com, video4linux-list@redhat.com, linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com

On Friday 21 November 2008, Trilok Soni wrote:
> > +
> > +static int
> > +tvp514x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > +{
> 
> Mark this as __init please.

No, don't.  It's for an I2C device ... which means it needs
to stay hotpluggable.

There are *very* few places it's correct to mark probe()
methods as __init, or even __devinit, and this isn't one
of those exceptions.

- Dave
