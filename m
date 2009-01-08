From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: Extended driver private controls?
Date: Thu, 08 Jan 2009 17:46:50 +0200
Message-ID: <49661FEA.5020409@nokia.com>
References: <494B59B5.2030800@nokia.com> <200812191548.34238.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37238 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZAHPsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 10:48:47 -0500
In-Reply-To: <200812191548.34238.hverkuil@xs4all.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hans Verkuil <hverkuil@xs4all.nl>
Cc: v4l <video4linux-list@redhat.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Hans Verkuil wrote:
> Hi Sakari,

Hello,

...
> What I did to support private controls is to allow drivers to add their own 
> controls to the various classes, as long as the low 16 bits are >= 0x1000.
> 
> You add them to videodev2.h (see the CX2341X private controls), and you just 
> pick a starting base such as 'V4L2_CTRL_CLASS_MPEG | 0x1100'.
> 
> This way the controls are together in one header, they have unique IDs, and 
> you can assign them to a specific class.
...
> So, to summarize: for new drivers I recommend using V4L2_CTRL_FLAG_NEXT_CTRL 
> and adding the private controls to videodev2.h and to prepare documentation 
> for inclusion with the v4l2 spec. If you really must support old apps, then 
> you might have to make duplicate PRIVATE_BASE controls (yuck!), but I hope 
> that won't be necessary.

Thanks, Hans, for the definitive answer. This is what we'll do then.

Cheers,

-- 
Sakari Ailus
sakari.ailus@nokia.com

