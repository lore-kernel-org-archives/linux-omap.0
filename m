From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: omap3camera and linux-omap
Date: Mon, 09 Aug 2010 20:35:05 +0300
Message-ID: <4C603C49.8090607@maxwell.research.nokia.com>
References: <4C5C129A.3020808@matrix-vision.de> <A24693684029E5489D1D202277BE894456DF59A3@dlee02.ent.ti.com> <4C6021AF.5010104@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:49474 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab0HIRfM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 13:35:12 -0400
In-Reply-To: <4C6021AF.5010104@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Michael and Sergio,

Michael Jones wrote:
> Aguirre, Sergio wrote:
>> Hi Michael,
>> 
>> 
>>> -----Original Message----- From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap- owner@vger.kernel.org] On Behalf Of Michael
>>> Jones Sent: Friday, August 06, 2010 8:48 AM To:
>>> linux-omap@vger.kernel.org Cc:
>>> sakari.ailus@maxwell.research.nokia.com Subject: omap3camera and
>>> linux-omap
>>> 
>>> I am currently using Sakari's omap3camera repository (branch
>>> 'devel'). 'git merge-base linux-omap omap3camera' tells me that
>>> the last commit omap3camera has in common with linux-omap is
>>> 40a0c47, from July 7 2010. But there are >1000 commits which are
>>> only in omap3camera, dating back to 2008.
>>> 
>>> Is this destined to stay this way?
>> 
>> This is because devel branch keeps a detailed development history
>> since we started working on the camera driver. At the end, the
>> patches submitted will be a consolidated set, which should end in
>> something around ~12 patches or so..
>> 
>>> Or will the omap3camera tree be merged into linux-omap at some
>>> point?
>> 
>> The omap3camera submission is on hold, because the camera driver is
>> dependant on Media controller framework, which is holding for merge
>> in linux-media mailing list.
>> 
>>> When proposing a patch for the omap3camera tree, should it be
>>> sent to this list?
>> 
>> You should preferably send the patches to linux-media (at)
>> vger.kernel.org mailing with cc to Sakari Ailus and Laurent
>> Pinchart.
>> 
>> So far we have been keeping patch review internally, because we
>> didn't want to pollute the mailing list with patches to unsubmitted
>> code.
>> 
>> Regards, Sergio
>> 
>>> Thanks, Michael
>>> 
> 
> Hi Sergio,
> 
> Thanks for the helpful reply.  Can you also clarify for me the
> difference between omap3camera and your linux-omap-camera
> (http://dev.omapzoom.org/?p=saaguirre/linux-omap-camera.git;a=summary)
> repositories?
> 
> I assume this development has mainly happened on the "board-rx51*"
> platform?

As Sergio noted, this is a tree for N900. The main point for the tree,
however, is the OMAP 3 ISP driver, which can be tested on N900 as the
tree also contains N900 sensor, lens and flash drivers.

> Ultimately I want to get raw sensor data to memory.  Do you foresee
> any problems doing that with the current state of omap3camera?  Might
> I be better off going with a kernel with v4l2_int_device at first?

Please don't. It's basically obsolete.

Go with v4l2_subdev instead. If you have a sensor driver to write, the
et8ek8 driver in the omap3camera tree can be used as an example on what
ops the sensor driver should implement.

Regards,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
