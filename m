From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v5 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Thu, 2 Dec 2010 16:00:12 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F0A4AB8@dbde02.ent.ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
	 <1290410585-29418-4-git-send-email-archit@ti.com>
	 <1291217886.10133.171.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035EFD6FE6@dbde02.ent.ti.com>
	 <1291282030.778.9.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035F0A4A5C@dbde02.ent.ti.com>
 <1291285184.778.17.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59663 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab0LBKaW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:30:22 -0500
In-Reply-To: <1291285184.778.17.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

Tomi Valkeinen wrote:
> On Thu, 2010-12-02 at 15:17 +0530, ext Taneja, Archit wrote:
>> Hi,
> 
>>> If you can split this patch into the two parts I suggested (if
>>> that's ok for you, you didn't comment on that one), and check if
>>> there's anything to add to the commit descriptions, I think we can
>>> go and apply this patch set.
>> 
>> If I split this into 2 parts, the first patch will be just a line
>> addition in display.h, I was beaten up by the community because of
>> this in the previous version. One line patches in a series aren't
>> taken very kindly :|. What I can do is clearly mention the 2 sets of
>> things which this commit does, if you think that is good enough.
> 
> Ah, hmm... I thought this patch also changed
> dss_recheck_connections() to use the new field, but now that
> I look at it, it doesn't. Why do you add the new
> channel-member here, if it's not used? Shouldn't it be added
> later, together with dss_recheck_connections()?

Yes, that makes more sense now, I had to introduce it early because
I used to call dssdev->channel and not dssdev->manager->id before.

The new version can have it with the dss_recheck_connections() change

> 
>>> Btw, on what platforms have you tested this (or generally any
>>> patches you send?). I only have 3430SDP currently that I can easily
>>> use to test, so my testing is a bit limited.
>>> 
>> 
>> This one I had tested throughly on 3430SDP, bootup on zoom2 and zoom3.
>> I couldn't test on omap2, we have a n800 board but we don't know what
>> panel driver we need to use, board-n8x0.c doesn't tell anything about.
>> If you can tell me what panel driver to use etc I can try out.
> 
> Unfortunately the panel driver for N800 has not been ported to DSS2.

I can possibly try with a 2430sdp, but I don't see the "omapdss" platform_device
board-2430dsp.c. Are you aware of any omap2 setup which I can use to test?

Archit
