From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: LCD blanking?
Date: Wed, 26 Aug 2009 08:30:59 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A49F54@dbde02.ent.ti.com>
References: <4A93ED3E.4030505@mlbassoc.com>
 <f67028d40908251736i1fb8037dy5aa41dad2d6621ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582AbZHZDBW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 23:01:22 -0400
In-Reply-To: <f67028d40908251736i1fb8037dy5aa41dad2d6621ca@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "frederik@kriewitz.eu" <frederik@kriewitz.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Frederik Kriewitz
> Sent: Wednesday, August 26, 2009 6:07 AM
> To: linux-omap@vger.kernel.org
> Subject: Re: LCD blanking?
> 
> On Tue, Aug 25, 2009 at 3:55 PM, Gary Thomas<gary@mlbassoc.com>
> wrote:
> > I have a system with an LCD, running Tomi's DSS2 support.
> > One problem I'm having is that after a while, the LCD blanks
> > out (I do have fbcon support enabled so I can use it as a
> > glass TTY - no keyboard)
> >
> > How can I keep this from happening?
> > Once it does, is there any way to get it back on (remember,
> > no keyboard)?
> 
[Hiremath, Vaibhav] The default console timeout is 10 min, so after this time LCD will blank, from user space you can do following - 

SYSFS entry - 
# echo 0 > /sys/class/graphics/fb0/blank

IOCTL - 

You can call the ioctl FBIOBLANK with argument FB_BLANK_UNBLANK.

Thanks,
Vaibhav

> check man console_codes
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

