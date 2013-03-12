From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 12 Mar 2013 20:31:28 +0530
Message-ID: <513F4348.3080203@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com> <513EC63A.5060707@ti.com> <513F05A0.6040204@ti.com> <513F2639.5060008@ti.com> <513F2F82.2040604@ti.com> <513F354F.40701@ti.com> <513F3BBA.6010209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257Ab3CLPCN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 11:02:13 -0400
In-Reply-To: <513F3BBA.6010209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday 12 March 2013 07:59 PM, Tomi Valkeinen wrote:
> On 2013-03-12 16:01, Archit Taneja wrote:
>> On Tuesday 12 March 2013 07:07 PM, Tomi Valkeinen wrote:
>
>>> So, I don't disagree with you. But I don't quite understand why we could
>>> not use the fixed channels for now? They should work in all the boards
>>> we have, right? Or is there something with DRM that forces the driver to
>>> select the channel dynamically?
>>
>> I think we can use fixed channels, but if the number of different fixed
>> channels crosses the number of crtcs the kernel wants, then we would
>> need to atleast change the channels of some of the outputs.
>>
>> For example, suppose omapdrm is asked to use only 2 crtcs, and it picks
>> up LCD2 and TV managers. Now if there is some panel which says it's
>> recommended channel is LCD, then things won't work.
>
> Are you saying omapdrm picks the managers for the crtcs before knowing
> what panels there are? That can't work right... We need to know what
> outputs are to be used before we can select the managers. Or, we always
> need crtcs for all the managers.

That's how it is right now.

>
> If we do know the panels, and thus outputs, then the managers to be used
> are found easily from output->dispc_channel.

Yes, my patch tries to do the same, but it could assign a manger which 
isn't the recommended channel. It can pick one from the list of 
supported channels. I've explained it a bit more below.

>
> But, of course, the crtc to manager mapping could be changed (if omapdrm
> supports this). If omapdrm is asked to use only 1 crtc, but there are
> two panels, then only one panel can be used at a time, and the manager
> for the crtc needs to be changed when the panel to be used is changed.
> But even in this case used manager is clear, it comes from
> output->dispc_channel.

This is something I don't know that can be done or not, or if it can be 
done easily. A crtc isn't purely an overlay manager. It also needs to 
have one plane associated to it. So, if we want to change the overlay 
manager tied to a crtc on the fly, we should make sure that it's still 
connected to a plane pointing to the same buffer. This needs a better 
understanding of drm internals. I guess Rob could answer this better.

>
>> At the moment, omapdrm maps a crtc with a manger using a function called
>> pipe2chan() which just selects a manager with the biggest channel no. So
>> if the kernel is configured to have num_crtcs as 1. The single crtc will
>> be mapped to LCD2. This method is wrong, as it doesn't even look at the
>> type of panels at all. For an omap5 panda, the most suitable manager to
>> map to the crtc would be TV(for hdmi).
>>
>> I think what we probably need to do is to combine both the methods. I.e,
>> make each output connectible to only one channel, and also iterate
>> through the panels in omapdrm to find the most suitable channels. So in
>> my patch, instead of looking at all the supported managers for an
>> output(checking with dss_feat_get_supported_outputs() on each manager),
>> I just look at the recommended channel, and try to map that manager.
>
> I don't know, I feel like I'm not understanding something here =).

:)

I think what I said above is equivalent to what you said here:

"If we do know the panels, and thus outputs, then the managers to be 
used are found easily from output->dispc_channel."

Instead of using output->dispc_channel, the patch I made tried to get 
the first supported channel(in increasing order of channel index) for an 
output. If that channel was already taken/reserved by a previous output, 
it tries to take the next supported channel if there are enough crtcs left.

My patch would break things if it chooses a manager for an output for 
which we haven't written the necessary code yet(switching clock sources 
etc).

So, what I'm saying is that we should stick to output->dispc_channel. We 
iterate through all the panels, and by using output->dispc_channel, we 
get the manager for an output, and map that manager to a crtc, and make 
sure the number of unique managers we finally use is equal to NUM_CRTC.

Does that sound good?

Archit

