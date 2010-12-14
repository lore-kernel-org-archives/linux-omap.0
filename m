From: "Hans Verkuil" <hverkuil@xs4all.nl>
Subject: Re: [alsa-devel] [RFC/PATCH v6 03/12] media: Entities,
  pads and links
Date: Tue, 14 Dec 2010 15:51:08 +0100
Message-ID: <997f50534838eeb6a31a526e65045635.squirrel@webmail.xs4all.nl>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
    <4CEF799E.7060508@ladisch.de> <4D06458B.6080808@ladisch.de>
    <201012141300.57118.laurent.pinchart@ideasonboard.com>
    <4D0771CB.3020809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D0771CB.3020809@ladisch.de>
Sender: linux-media-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lennart@poettering.net, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> Laurent Pinchart wrote:
>> On Monday 13 December 2010 17:10:51 Clemens Ladisch wrote:
>>> TYPE_EXT describes entities that represent some interface to the
>>> external world, TYPE_INT those that are internal to the entire device.
>>> (I'm not sure if that distinction is very useful, but TYPE_SUBDEV seems
>>> to be an even more meaningless name.)
>>
>> SUBDEV comes from the V4L2 world, and I agree that it might not be a
>> very good
>> name.
>>
>> I'm not sure I would split entities in internal/external categories. I
>> would
>> create a category for connectors though.
>
> I'm not disagreeing, but what is actually the distinction between types
> and subtypes?  ;-)

The type tells what the behavior is of an entity. E.g., type DEVNODE
represents device node(s) in userspace, V4L2_SUBDEV represents a v4l2
sub-device, etc. The subtype tells whether a V4L2_SUBDEV is a sensor or a
receiver or whatever. Nice to know, but it doesn't change the way
sub-devices work.

In the case of connectors you would create a CONNECTOR type and have a
bunch of subtypes for all the variations of connectors.

That said, I'm not sure whether the distinction is useful for DEVNODEs.
You do need to know the subtype in order to interpret the union correctly.

Laurent, does the MC code test against the DEVNODE type? I.e., does the MC
code ignore the subtype of a DEVNODE, or does it always use it?

Regards,

        Hans

-- 
Hans Verkuil - video4linux developer - sponsored by Cisco
