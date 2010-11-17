From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v4 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Wed, 17 Nov 2010 18:26:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035E84A66B@dbde02.ent.ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
	 <1289219065-1362-4-git-send-email-archit@ti.com>
	 <1289904957.2668.75.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087034C10218C@dbde02.ent.ti.com>
 <1289914375.2668.96.camel@tubuntu>
 <FCCFB4CDC6E5564B9182F639FC356087035E84A4B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59880 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0KQM4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 07:56:23 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087035E84A4B3@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
>> On Tue, 2010-11-16 at 12:22 +0100, ext Taneja, Archit wrote:
>>> Hi,
>>> 
>>> Tomi Valkeinen wrote:
>>>> Hi,
>>>> 
>>> 
>>> [snip]
>>> 
>>>>> diff --git a/arch/arm/plat-omap/include/plat/display.h
>>>>> b/arch/arm/plat-omap/include/plat/display.h
>>>>> index 586944d..3e6eec1 100644
>>>>> --- a/arch/arm/plat-omap/include/plat/display.h
>>>>> +++ b/arch/arm/plat-omap/include/plat/display.h
>>>>> @@ -434,6 +434,7 @@ struct omap_dss_device {
>>>>>         struct omap_overlay_manager *manager;
>>>>> 
>>>>>         enum omap_dss_display_state state;
>>>>> +       enum omap_channel channel;
>>>> 
>>>> Isn't this the same as dssdev->manager->id?
>>>> 
>>>> Yes, this channel stuff is a bit confusing, even the enum "omap_channel"
>>>> is badly named (should at least have "dss" in it). But
>>>> omap_overlay_manager should represent the output pipe, so I don't
>>>> think there's need for channel field in dss_device.
>>> 
>>> The panel somehow needs to tell which manager it is connected to. We
>>> went with with the way of declaring a new member 'channel' and
>>> setting that parameter up in the board file.
>>> 
>>> The current way to relate the manager and device is done by checking
>>> the dssdev->type in dss_recheck_connections() and then calling set_device()
>>> 
>>> This is not sufficient any more since two of the managers can support
>>> similar types of displays. 
>>> 
>>> So in the channel approach the following happens:
>>> 
>>> -mgr->id's are initialized at bootup.
>>> -devices and managers are connected using 'channel'.
>>> -mgr->id automatically becomes equal to channel.
>>> 
>>> Can we set something like dssdev->manager->id in the board file itself?
>> 
>> Right, now I see.
>> 
>> The dss_recheck_connections() felt like a hack when I wrote it =).
>> Clearly we need some way to define in the board file which panel connects to
>> which manager. 
>> 
> 
> It wasn't needed probably for OMAP3 since all non-venc panels
> connect to LCD and venc to VENC type.
> 
> Now that I think of it, what channel would we mention if the
> panel is used in dsi l4 update mode or dma mode? It should
> have no manager at all.
> 
>> Perhaps move the channel-field up, just below "enum omap_display_type
>> type". The lines in the beginning of omap_dss_device are things which
>> define the interface etc, and later there are miscallaneous dynamic
>> things. And this belongs to the former.
>> 
>> Now, if we have the channel defined in this way in the
>> omap_dss_device, I'm wondering if:
>> 1) the manager pointer is needed at all, as the channel tells which
>> manager it is? 2) if we keep the manager pointer (as a helper
>> shortcut), should the code use generally use
> dssdev->channel or dssdev->manager->id?
> 
> I think manager->id makes more sense considering your logic below.
> 
>> 3) having this channel field requires a change to every board file,
>> because the channel has to be defined?
>> 
> 
> Yes, that is something that has to be done for all 'DIGIT'
> panels across all boards.
> 
>> And answering to myself, I guess the manager pointer is needed, because
>> DSS2 supports (at least in theory) multiple panels in the same
>> interface (not at the same time, of course). This means that we could
>> have to panels, with the same interface and channel, but only one
>> would be in use. So the one in use should have manager pointing to the
>> correct manager, and the other would have manager NULL.
>> 
> 
> Yes, passing dssdev->channel would make things worse if 2
> panels are connected to same interface.
> 
>> And thus perhaps using dssdev->channel only for connecting the right
>> manager to right panel, and using
>> dssdev->manager->id for other uses would be the best? The
>> values would of course be the same, but at least we'd get a crash if
>> somehow an unconnected display is being used for configuration.
>> 
> 
> Even in the current kernel on 3430sdp, the board file adds
> sharp_ls, venc and generic panels If I boot up with venc as
> default display, mgr0 has dvi as its display and mgr1 has tv.
> So if I try to enable sharp_ls panel I get a crash when we
> first try to access dssdev->manager in dpi_display_enable().
> We should have a way to prevent enabling a panel if it isn't
> connected to a manager. We should also have a way to allow a
> panel to have no channel at all (something like
> OMAP_DSS_CHANNEL_NONE) if we are using something like dsi l4 update.
> 
> I won't add this extra channel now though, we need to think
> of a better way later.
> 

Also, do you think when a display unsets a manager and sets a new manager
the channel should be changed? Or should it purely be a one time thing
for choosing the correct manager and not use it anywhere else?

Thanks,

Archit

>> Does this make sense?
> 
> Yes, it does, I'll make these changes, and more if you can
> think of any.
> 
> Archit--
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html