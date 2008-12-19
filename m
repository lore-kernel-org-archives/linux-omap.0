From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Extended driver private controls?
Date: Fri, 19 Dec 2008 15:48:34 +0100
Message-ID: <200812191548.34238.hverkuil@xs4all.nl>
References: <494B59B5.2030800@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:1511 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYLSOsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 09:48:54 -0500
In-Reply-To: <494B59B5.2030800@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: v4l <video4linux-list@redhat.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sakari,

On Friday 19 December 2008 09:22:13 Sakari Ailus wrote:
> Hello,
>
> I'm wondering how to use extended driver private controls. Controls
> starting from V4L2_CID_PRIVATE_BASE do not work (check_ext_ctrls() in
> v4l2-ioctl.c:
>
> ---
>          /* V4L2_CID_PRIVATE_BASE cannot be used as control class
>             when using extended controls.
>             Only when passed in through VIDIOC_G_CTRL and VIDIOC_S_CTRL
>             is it allowed for backwards compatibility.
>           */
>          if (!allow_priv && c->ctrl_class == V4L2_CID_PRIVATE_BASE)
>                  return 0;
> ---
>
> check_ext_ctrls() is called from __video_do_ioctl() with allow_priv set
> to zero for extended controls.
>
> I know I could create another control class and define that in
> videodev2.h but that feels like a bit of overkill for two integer
> controls... :-) Are there any alternatives if I would like my private
> controls to be available through extended controls as well?

Good question. The situation is as follows: the whole PRIVATE_BASE stuff is 
a really bad design. Controls are part of the public API of V4L2 and as 
such should be documented in the v4l2 spec and clearly defined. Using 
PRIVATE_BASE, however, means that different drivers will have controls with 
the same ID but that do different things. Furthermore, there is no way to 
classify controls like that (e.g. is it a general user control, an mpeg 
control, a camera control?).

So when I designed the extended controls API I wanted to force developers to 
use a different approach. If you look at videodev2.h you will see that a 
control ID is divided up in bitranges:

Bits 28-31 are for flags (currently on V4L2_CTRL_FLAG_NEXT_CTRL is used).

Bits 16-27 denote the class (USER, MPEG and CAMERA are currently defined).

Bits 0-15 are the control ID within the class.

In addition there is the guarantee that bits 0-15 can never be all 0 for any 
valid control.

The current PRIVATE_BASE stuff doesn't really fit in any of this.

What I did to support private controls is to allow drivers to add their own 
controls to the various classes, as long as the low 16 bits are >= 0x1000.

You add them to videodev2.h (see the CX2341X private controls), and you just 
pick a starting base such as 'V4L2_CTRL_CLASS_MPEG | 0x1100'.

This way the controls are together in one header, they have unique IDs, and 
you can assign them to a specific class.

Unfortunately, there are three obstacles:

1) Many apps and drivers still don't use V4L2_CTRL_FLAG_NEXT_CTRL and only 
know about PRIVATE_BASE.
2) It's a bit tricky to implement correct control handling in v4l drivers.
3) Documenting is a bit hard at the moment since the V4L2 spec is maintained 
elsewhere.

Since drivers that implement VIDIOC_S_EXT_CTRLS are generally new drivers 
I've blocked the use of PRIVATE_BASE with that ioctl, hopefully encouraging 
driver writers to properly define their controls in videodev2.h, document 
them in the v4l2 spec and to implement V4L2_CTRL_FLAG_NEXT_CTRL handling.

That doesn't address the fact that many applications still don't know about 
it. It depends on what sort of environment the driver will be used in 
whether you need to add duplicate PRIVATE_BASE controls for the time being. 
When I created the MPEG controls I didn't make duplicates since any 
application that needed to support MPEG had to make changes anyway. In the 
case of embedded platforms you probably have a similar situation. But if 
you make a simple TV grabber driver, then many apps like xawtv or tvtime 
only know about PRIVATE_BASE controls. In that case the only solution is to 
provide a duplicate set of PRIVATE_BASE controls.

The other disadvantage is that it is more work at the moment. I hope to 
address that in the coming months by adding proper control support to the 
v4l2 framework. I have several ideas for this and now that v4l2_device and 
v4l2_subdev are both in it should be quite feasible. If it all works as I 
hope then the driver control support will become much, much simpler.

The final problem relates to the fact that the documentation is currently 
maintained out-of-tree. We want to move it all to the repository in 1-2 
months from now and that should make it much easier to update the docs when 
you add new private controls.

So, to summarize: for new drivers I recommend using V4L2_CTRL_FLAG_NEXT_CTRL 
and adding the private controls to videodev2.h and to prepare documentation 
for inclusion with the v4l2 spec. If you really must support old apps, then 
you might have to make duplicate PRIVATE_BASE controls (yuck!), but I hope 
that won't be necessary.

It's not an ideal situation, but I hope that it will improve considerably in 
the next 3-6 months.

Regards,

	Hans

PS: please note that there are several control utility functions in 
v4l2-common.c! These might prove useful.

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
