From: Nishanth Menon <nm@ti.com>
Subject: video_omap4 and control module access (was ... from opensuse-arm
 list)
Date: Thu, 5 Jun 2014 11:47:19 -0500
Message-ID: <53909F17.4070701@ti.com>
References: <537900CE.70403@suse.de> <s5hioof1o4c.wl%tiwai@suse.de> <53907297.800@ti.com> <1579651.p7EvQrgbMT@avalon> <53909816.5090201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35479 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbaFEQrm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jun 2014 12:47:42 -0400
In-Reply-To: <53909816.5090201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alexander Graf <agraf@suse.de>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, devel@driverdev.osuosl.org, linux-omap <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Tero Kristo <t-kristo@ti.com>, "tony@atomide.com" <tony@atomide.com>

Full thread in opensuse mailing list:

http://lists.opensuse.org/archive/opensuse-arm/2014-06/msg00004.html

Moving this thread out of opensuse to kernel public lists +CC of
maintainers relevant to the control module/clk.

On 06/05/2014 11:17 AM, Nishanth Menon wrote:
> On 06/05/2014 10:56 AM, Laurent Pinchart wrote:
>> Hi Nishanth,
>>
>> On Thursday 05 June 2014 08:37:27 Nishanth Menon wrote:
>>> On 06/05/2014 08:29 AM, Takashi Iwai wrote:
>>>> Alexander Graf wrote:
>>>>> On 04.06.14 09:28, Matwey V. Kornilov wrote:
>>>>>> On 19.05.2014 14:02, Alexander Graf wrote:
>>>>>>>> note: expected 'uint32_t *' but argument is of type 'dma_addr_t *'
>>>>>>
>>>>>> I've fixed that one, but can not figure out what is wrong now:
>>>>>>
>>>>>> https://build.opensuse.org/package/live_build_log/home:matwey:pcm051:13.
>>>>>> 2/kernel-default/standard/armv7l>> 
>>>>>
>>>>> If I had to guess I'd say someone forgot to put a few EXPORT_SYMBOLs
>>>>> into the code and never tested whether compiling his v4l / video driver
>>>>> actually works when it's compiled as a module.
>>>>
>>>> The problem is CONFIG_VIDEO_OMAP4=y while the whole V4L stuff is built
>>>> as modules.  You have to build V4L into kernel, too.
>>>> That said, it's a Kconfig dependency issue.
>>>>
>>>> Looking at the code, though, omap4-iss driver itself is written to be
>>>> built also as a module.  But its Kconfig is bool, so the problem
>>>> happens.  Maybe a patch like below works?
>>>>
>>>> Takashi
>>>>
>>>> ---
>>>> diff --git a/drivers/staging/media/omap4iss/Kconfig
>>>> b/drivers/staging/media/omap4iss/Kconfig index 78b0fba7047e..0c3e3c1acd4f
>>>> 100644
>>>> --- a/drivers/staging/media/omap4iss/Kconfig
>>>> +++ b/drivers/staging/media/omap4iss/Kconfig
>>>> @@ -1,5 +1,5 @@
>>>>
>>>>  config VIDEO_OMAP4
>>>> -	bool "OMAP 4 Camera support"
>>>> +	tristate "OMAP 4 Camera support"
>>>>  	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && I2C && ARCH_OMAP4
>>>>  	select VIDEOBUF2_DMA_CONTIG
>>>>  	---help---
>>>
>>> +Sakari and Laurent. Full thread:
>>> http://lists.opensuse.org/archive/opensuse-arm/2014-06/msg00004.html
>>>
>>> I agree, I see no reason for these to be bool.
>>
>> There's no good reason for the option to be a boolean, but there's a bad 
>> reason :-/ The OMAP4 ISS driver calls the omap4_ctrl_pad_readl() and 
>> omap4_ctrl_pad_writel() functions, which are not exported. The right way to 
>> fix this would be to implement a control module driver for the OMAP4, but 
>> that's not a straightforward task, and I don't have time to do so at the 
>> moment.
>>
> 
> a) control module:
> from: drivers/staging/media/omap4iss/iss_csiphy.c
>   /*
>    * SCM.CONTROL_CAMERA_RX
>    * - bit [31] : CSIPHY2 lane 2 enable (4460+ only)
>    * - bit [30:29] : CSIPHY2 per-lane enable (1 to 0)
>    * - bit [28:24] : CSIPHY1 per-lane enable (4 to 0)
>    * - bit [21] : CSIPHY2 CTRLCLK enable
>    * - bit [20:19] : CSIPHY2 config: 00 d-phy, 01/10 ccp2
>    * - bit [18] : CSIPHY1 CTRLCLK enable
>    * - bit [17:16] : CSIPHY1 config: 00 d-phy, 01/10 ccp2
>    */
>   cam_rx_ctrl = omap4_ctrl_pad_readl(
> OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX);
> 
> Is'nt that what pinctrl does? And should be rather trivial to do, no?
> 
> c) if there is something else that these bits do that I cant figure
> out, example: for specific stuff like control module bit for clock
> (which the above code kinda sounds similar to), like how we had for
> display recently - model it with dts clock[1]
> 
> b) if you cannot use existing frameworks OR use pinctrl, last ditch
> way to do it in pdata-quirks in mach-omap2 with fops being send over.
> 
> We did debate putting entire control module as a syscon_driver, the
> current split (prior to syscon) just makes it impractical to switch
> over to it at this point in time, maybe once all dt-fication is done,
> it might be possible to switch over to that.
> 
> [1] http://marc.info/?l=linux-omap&m=140127434229399&w=2
> 


-- 
Regards,
Nishanth Menon
