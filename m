From: "George.Qiao" <qiao_shanshan@visualon.com>
Subject: Re: Status of Beagle Board
Date: Fri, 08 May 2009 14:26:31 +0800
Message-ID: <4A03D097.5090605@visualon.com>
References: <1228470882.25798.23.camel@david-nb.visualon.local>	 <2A3DCF3DA181AD40BDE86A3150B27B6B02D110A3FA@dbde02.ent.ti.com>	 <0680EC522D0CC943BC586913CF3768C002D97E9BA9@dbde02.ent.ti.com>	 <1228990380.29333.11.camel@david-nb.visualon.local>	 <0680EC522D0CC943BC586913CF3768C002DD2C6F5C@dbde02.ent.ti.com>	 <1241078747.19525.23.camel@localhost.localdomain>	 <FD6982799649459A93E724A62BF2E64F@LinHPNotebook>	 <0680EC522D0CC943BC586913CF3768C00378655555@dbde02.ent.ti.com> <1241617391.3362.23.camel@localhost.localdomain> <0680EC522D0CC943BC586913CF3768C003787AB074@dbde02.ent.ti.com> <4A0259D5.6090204@visualon.com> <0680EC522D0CC943BC586913CF3768C003787AB131@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E739404323ED91C@dbde02.ent.ti.com> <4A028CBF.8030507@visualon.com> <19F8576C6E063C45BE387C6
 4729E739404323ED97B@dbde02.ent.ti.com> <4A02B60A.2010006@visualon.com> <19F8576C6E063C45BE387C64729E739404323ED9F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from reserve.cableplus.com.cn ([218.242.229.234]:41469 "EHLO
	mail.visualon.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbZEHGvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 02:51:37 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404323ED9F7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "wan_jinxue@visualon.com" <wan_jinxue@visualon.com>, Bill Lin <blin@visualon.com>, "shawnofarrell@visualon.com" <shawnofarrell@visualon.com>, "Chatterjee, Amit" <amit.chatterjee@ti.com>, "Andrews, Gerard" <gerard@ti.com>, "Kridner, Jason" <jdk@ti.com>, 'Bangfei Jin' <jin_bangfei@visualon.com>, 'Xuejun Dong' <dong_xuejun@visualon.com>, 'YangCai' <yangcai@visualon.com>, linux-omap@vger.kernel.org

Hi Vaibhav Hiremath,

My application can work in OMAP3 EVM and other v4l2 platform, but there 
is another issue in beagle board. as follow:

1. NormalSize() -> RequestBuffer() -> mmap()
2. playing...
3. FullScreen() -> VIDIOC_STREAMOFF
                          -> munmap()
                          -> VIDIOC_REQBUFS
                          -> VIDIOC_QUERYBUF
                          -> RequestBuffer() -> mmap()
                          -> VIDIOC_S_CROP
                          -> VIDIOC_S_FMT
                          -> VIDIOC_QBUF
                          -> VIDIOC_STREAMON

When I want to call VIDIOC_REQBUFS in FullScreen(), it always fail.


Best Regards,
George.Qiao

============================
> Great, please see my comments in-lined below - 
>
>
> Thanks,
> Vaibhav Hiremath
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
>
>   
>> -----Original Message-----
>> From: George.Qiao [mailto:qiao_shanshan@visualon.com]
>> Sent: Thursday, May 07, 2009 3:51 PM
>> To: Hiremath, Vaibhav
>> Cc: Syed Mohammed, Khasim; Shah, Hardik; wan_jinxue@visualon.com;
>> Bill Lin; shawnofarrell@visualon.com; Chatterjee, Amit; Andrews,
>> Gerard; Kridner, Jason; 'Bangfei Jin'; 'Xuejun Dong'; 'YangCai';
>> linux-omap-open-source@linux.omap.com
>> Subject: Re: Status of Beagle Board
>>
>> Dear Vaibhav Hiremath,
>>
>> I can play video by v4l2 now!  Thank you!
>>
>> I have add code in board-omap3beagle.c :
>>
>> #ifdef CONFIG_FB_OMAP2
>> static struct resource omap3beagle_vout_resource[3 -
>> CONFIG_FB_OMAP2_NUM_FBS] = {
>> };
>> #else
>> static struct resource omap3beagle_vout_resource[2] = {
>> };
>> #endif
>>
>> static struct platform_device omap3beagle_vout_device = {
>>        .name                   = "omap_vout",
>>        .num_resources  = ARRAY_SIZE(omap3beagle_vout_resource),
>>        .resource               = &omap3beagle_vout_resource[0],
>>        .id             = -1,
>> };
>>
>> static struct platform_device *omap3_beagle_devices[] __initdata = {
>>     &beagle_dss_device,
>>     &leds_gpio,
>>     &keys_gpio,
>>     &omap3beagle_vout_device,
>> };
>>
>>
>> I have got some omapdss error and voutBuffer Size. as follow:
>>
>> omapdss: Could not find exact pixel clock. Requested 23500 kHz, got
>> 24000 kHz
>> omapdss error: display already enabled
>> omap_voutDisplay already enabled
>> omapdss error: display already enabled
>> omap_voutDisplay already enabled
>>     
>
>
> [Hiremath, Vaibhav] This is not an error as such, it warning message. Actually here we are trying to enable the display which has already been enabled by Fbdev. 
> We can suppress this message, atleast during init.
>
>   
>> omap_voutBuffer Size = 3686400
>> omap_vout: registered and initialized video device 0 [v4l2]
>> omap_voutBuffer Size = 3686400
>> omap_vout: registered and initialized video device 1 [v4l2]
>>
>>     
>
> [Hiremath, Vaibhav] This is just a debug massage; it is neither a error nor a warning. So don't worry.
>
> Can you share the code-base or submit the patches to the list, so that interested people can use it.
>
>   
>> Could I change 'voutBuffer Size'?  How to fix it?
>>
>> Best Regards,
>> George.Qiao
>>
>> =======================
>>     
>>> Yes Definitely this is the issue. If the platform_device.name
>>>       
>> doesn't match with the platform_driver.driver.name then your probe
>> function will not be called at all.
>>     
>>> Can you just copy the board-omap3evm.c changes related to
>>>       
>> V4L2/DSS2 and give a shot? I think it should work straight away.
>>     
>>> Please let me know if you need any further clarification or help.
>>>
>>> Thanks,
>>> Vaibhav Hiremath
>>> Platform Support Products
>>> Texas Instruments Inc
>>> Ph: +91-80-25099927
>>>
>>>
>>>       
>>>> -----Original Message-----
>>>> From: George.Qiao [mailto:qiao_shanshan@visualon.com]
>>>> Sent: Thursday, May 07, 2009 12:55 PM
>>>> To: Hiremath, Vaibhav
>>>> Cc: Syed Mohammed, Khasim; Shah, Hardik; wan_jinxue@visualon.com;
>>>> Bill Lin; shawnofarrell@visualon.com; Chatterjee, Amit; Andrews,
>>>> Gerard; Kridner, Jason; 'Bangfei Jin'; 'Xuejun Dong'; 'YangCai';
>>>> linux-omap-open-source@linux.omap.com
>>>> Subject: Re: Status of Beagle Board
>>>>
>>>> Hi Hiremath, Vaibhav,
>>>>
>>>> Thank you very much for your instant response!
>>>>
>>>> I've checked the file 'board-omap3beagle.c' and found nothing
>>>> looking
>>>> like omap_vout in it, no platform_device, either. And I've also
>>>> compared
>>>> it with board-omap3evm.c.
>>>>
>>>> Below is some difference between them:
>>>>
>>>> board-omap3evm.c has:
>>>> *+static struct platform_device omap3evm_vout_device = {
>>>> **+       .name                   = "omap_vout",
>>>> ...
>>>> }
>>>> *
>>>> But 'board-omap3beagle.c' does not have anything looking like:
>>>>
>>>> *+static struct platform_device omap3beagle_vout_device = {*
>>>> *+       .name                   = "omap_vout",
>>>> ...
>>>> }
>>>> *
>>>> So, I think there's no patch on V4L2 for beagle done and this is
>>>>         
>> the
>>     
>>>> root cause of this issue. Do you agree with me? Thanks a lot.
>>>>
>>>>
>>>> Best Regards,
>>>> George.Qiao
>>>> ===================================
>>>>
>>>>
>>>>         
>>>>> Hi George,
>>>>>
>>>>> I have looked into your config file and it looks ok to me.
>>>>>
>>>>> Can you conform that, you have added "platform_device"
>>>>>           
>> definitions
>>     
>>>> in board-omap3beagle.c?
>>>>
>>>>         
>>>>> Can you please create complete patch on top of your baseline (O-
>>>>>           
>> L
>>     
>>>> and Tomi's tree), so that I can review that directly? I will be
>>>> seeing complete changes done for beagle.
>>>>
>>>>         
>>>>> Thanks,
>>>>> Vaibhav Hiremath
>>>>> Platform Support Products
>>>>> Texas Instruments Inc
>>>>> Ph: +91-80-25099927
>>>>>
>>>>>
>>>>>
>>>>>           
>>>
>>>       
>
>
>   

