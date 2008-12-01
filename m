From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH] Add Omnivision OV9640 sensor support.
Date: Mon, 1 Dec 2008 13:34:41 +0100
Message-ID: <200812011334.41306.hverkuil@xs4all.nl>
References: <5d5443650811280216r450c6f02v3fb0db2e1580594a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:2796 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYLAMfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 07:35:08 -0500
In-Reply-To: <5d5443650811280216r450c6f02v3fb0db2e1580594a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>

On Friday 28 November 2008 11:16:20 Trilok Soni wrote:
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni

Hi Trilok,

I reviewed this sensor driver and it's fine except for one thing: 
setting the default registers from outside the driver. This is a really 
bad idea. I2C drivers should be self-contained. I've made the same 
comment in the tvp514x driver review which I'm copying below (with some 
small edits):

This driver relies on an outside source to do the initialization of the 
registers. This is very much the wrong approach. It would require all 
platforms/master drivers that are going to use this chip to program the 
chip's registers. That's not the way to do it. The ov9640 driver should 
do this and the bridge driver should only pass high-level config data 
(such as with input/output pins are being used, signalling setup, 
whatever). This is how for example the Micron sensor mt* drivers do it. 
This approach means that all the relevant programming is inside the 
chip's driver and that bridge drivers can easily replace one chip for 
another since except for a little bit of initialization (usually 
routing, signalling setup) there is otherwise no difference between 
using one chip or another.

Remember that this is not a driver for use with omap, this is a generic 
i2c driver for this chip. omap just happens to be the only one using it 
right now, but that can easily change.

Yes, it makes it harder to write an i2c driver, but experience has shown 
us that the advantages regarding reuse far outweigh this initial cost.

I noticed that the tcm825x.c driver takes exactly the same wrong 
approach, BTW.

Regards,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
