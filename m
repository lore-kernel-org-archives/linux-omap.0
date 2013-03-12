From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 12 Mar 2013 19:31:51 +0530
Message-ID: <513F354F.40701@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com> <513EC63A.5060707@ti.com> <513F05A0.6040204@ti.com> <513F2639.5060008@ti.com> <513F2F82.2040604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab3CLOCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 10:02:36 -0400
In-Reply-To: <513F2F82.2040604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday 12 March 2013 07:07 PM, Tomi Valkeinen wrote:
> On 2013-03-12 14:57, Archit Taneja wrote:
>
>>>> We could also use the recommended channel way for omapdrm, I can't
>>>> figure out what's the better approach at the moment.
>>>
>>> Hmm, I think it'd be safer to use the recommended channel from omapdss
>>> for now. The current omapdss code doesn't really let you use any other
>>> channel than the recommended one (which was thus renamed to
>>> dispc_channel in my later version).
>>
>> I think omapdss needs to give the freedom to set a different dispc
>> manager for an output. This is because in omapdrm crtcs are sort of
>> floating, and when a connector(and it's encoder) needs to be enabled, it
>> tries to look search for a crtc it can connect to. If omapdss sort of
>> fixes the output->manager link, which is not how it should work.
>>
>> I think it is fine for us to use this approach for omapfb when creating
>> the links, but not within dss.
>>
>> For example, the code here:
>>
>> -    /*
>> -     * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
>> -     * source for DPI is SoC integration detail, not something that should
>> -     * be configured in the dssdev
>> -     */
>> -    dsidev = dpi_get_dsidev(dssdev->channel);
>> +    dsidev = dpi_get_dsidev(dpi.output.dispc_channel);
>>
>> We are sort of using the recommended channel to figure out which DSI pll
>> to use. We don't have much of an option here because dpi_init_display()
>> happens much earlier. But if it were to connect to a different manager
>> later on, we would get into trouble.
>
> Right. It should be changed to allow dynamic dispc channel changes (as I
> said in my mail). But that requires changing how the output drivers and
> the output.c work. Perhaps nothing too difficult, but just something
> that has not been done =).
>
>>> Or does your patch do a better job at selecting the outputs (I'm mostly
>>> thinking about OMAP5 here, which has a bit more conflicts with the mgrs
>>> and outputs than earlier omaps).
>>
>> My approach is very drm oriented, the problem with omapdrm right now is
>> that we want to limit the number of crtcs(which map to managers). The
>> lesser the number of crtcs, the more free planes we have for overlaying.
>>
>> If through bootargs or CONFIG, we set NUM_CRTCs to 2. We can only set up
>> only 2 overlay managers. My patch just tries to figure out which are the
>> best 2 managers to choose out of the total number of managers, in such a
>> way that most encoders/panels on the platform are supported.
>>
>> The drm framework(I think) keeps the connections between crtc and
>> encoders flexible through the possible_crtcs flag maintained by
>> encoders. It figures out which crtc is free, and tries to use that one
>> at that moment. Once that encoder is done using it, the crtc can be used
>> by another encoder later. We can also change the crtc of an
>> encoder(after it's off).
>>
>> So omapdss fixing the dispc channel for an output doesn't seem suitable
>> for drm.
>
> So, I don't disagree with you. But I don't quite understand why we could
> not use the fixed channels for now? They should work in all the boards
> we have, right? Or is there something with DRM that forces the driver to
> select the channel dynamically?

I think we can use fixed channels, but if the number of different fixed 
channels crosses the number of crtcs the kernel wants, then we would 
need to atleast change the channels of some of the outputs.

For example, suppose omapdrm is asked to use only 2 crtcs, and it picks 
up LCD2 and TV managers. Now if there is some panel which says it's 
recommended channel is LCD, then things won't work.

At the moment, omapdrm maps a crtc with a manger using a function called 
pipe2chan() which just selects a manager with the biggest channel no. So 
if the kernel is configured to have num_crtcs as 1. The single crtc will 
be mapped to LCD2. This method is wrong, as it doesn't even look at the 
type of panels at all. For an omap5 panda, the most suitable manager to 
map to the crtc would be TV(for hdmi).

I think what we probably need to do is to combine both the methods. I.e, 
make each output connectible to only one channel, and also iterate 
through the panels in omapdrm to find the most suitable channels. So in 
my patch, instead of looking at all the supported managers for an 
output(checking with dss_feat_get_supported_outputs() on each manager), 
I just look at the recommended channel, and try to map that manager.

This way, we have a better approach than the pipe2chan() thing, but we 
restrict each encoder to connect to only one crtc, which we could extend 
later if the need arises.

Should we go with this approach then?

>
> As long as omapdss doesn't handle switching the clock sources (and
> perhaps some other settings also, like OMAP5's DPI video source
> selection. we've never had support for changing the channel later.),
> having omapdrm select the channels could lead to problems if it happens
> to select the wrong channel.

Yes, most of the other combinations wont work because of missing things 
like clock source selection in DSS_CTRL and using the other video port 
of DSI.

Archit

