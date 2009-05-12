From: "George.Qiao" <qiao_shanshan@visualon.com>
Subject: Re: Status of Beagle Board
Date: Tue, 12 May 2009 16:05:25 +0800
Message-ID: <4A092DC5.7020305@visualon.com>
References: <1228470882.25798.23.camel@david-nb.visualon.local>	 <1228990380.29333.11.camel@david-nb.visualon.local>	 <0680EC522D0CC943BC586913CF3768C002DD2C6F5C@dbde02.ent.ti.com>	 <1241078747.19525.23.camel@localhost.localdomain>	 <FD6982799649459A93E724A62BF2E64F@LinHPNotebook>	 <0680EC522D0CC943BC586913CF3768C00378655555@dbde02.ent.ti.com> <1241617391.3362.23.camel@localhost.localdomain> <0680EC522D0CC943BC586913CF3768C003787AB074@dbde02.ent.ti.com> <4A0259D5.6090204@visualon.com> <0680EC522D0CC943BC586913CF3768C003787AB131@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E739404323ED91C@dbde02.ent.ti.com> <4A028CBF.8030507@visualon.com> <19F8576C6E063C45BE387C64729E739404323ED97B@dbde02.ent.ti.com> <4A02B60A.2010006@visualon.com> <19F8576C6E063C45BE387C64729E739404323ED9F7@dbde02.ent.ti
 .com> <4A03D097.5090605@visualon.com> <19F8576C6E063C45BE387C64729E739404323EDBDE@dbde02.ent.ti.com> <4A07CBF4.3000902@visualon.com> <19F8576C6E063C45BE387C64729E739404323EE137@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from reserve.cableplus.com.cn ([218.242.229.234]:46840 "EHLO
	mail.visualon.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZELIF5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 04:05:57 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404323EE137@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "wan_jinxue@visualon.com" <wan_jinxue@visualon.com>, Bill Lin <blin@visualon.com>, "shawnofarrell@visualon.com" <shawnofarrell@visualon.com>, "Chatterjee, Amit" <amit.chatterjee@ti.com>, "Andrews, Gerard" <gerard@ti.com>, "Kridner, Jason" <jdk@ti.com>, 'Bangfei Jin' <jin_bangfei@visualon.com>, 'Xuejun Dong' <dong_xuejun@visualon.com>, 'YangCai' <yangcai@visualon.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hiremath Vaibhav,

Thank you very much for v4l2 on beagle!

We want to use your branch to demo our video player,  I can not enable=20
sound and usb-mouse in beagle board.

What's the difference between beagle kernel and your branch kernel for=20
sound and usb driver?

Thanks & Best Regards,
George.Qiao
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Hi George,
>
> Yes I do agree, at-least for me this looks like a small bug in V4L2 d=
river. But just to make double sure I will discuss this with Hardik and=
 let you know.
>
> Thanks,
> Vaibhav Hiremath
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
>  =20
>> -----Original Message-----
>> From: George.Qiao [mailto:qiao_shanshan@visualon.com]
>> Sent: Monday, May 11, 2009 12:26 PM
>> To: Hiremath, Vaibhav
>> Cc: Syed Mohammed, Khasim; Shah, Hardik; wan_jinxue@visualon.com;
>> Bill Lin; shawnofarrell@visualon.com; Chatterjee, Amit; Andrews,
>> Gerard; Kridner, Jason; 'Bangfei Jin'; 'Xuejun Dong'; 'YangCai';
>> linux-omap@vger.kernel.org
>> Subject: Re: Status of Beagle Board
>>
>> Hi Hiremath Vaibhav,
>>
>> I have fixed this bugs in omap_vout.c :
>>
>> vidioc_streamoff()
>> {
>> ...
>> - return ovl->set_overlay_info(ovl, &info);
>> + ovl->set_overlay_info(ovl, &info);
>> ...
>> }
>>
>> because it should not return ovl->set_overlay_info() here, in this
>> way,
>> the below code will not be executed:
>> videobuf_streamoff() -> videobuf_queue_cancel()
>> {
>> ...
>> q->streaming =3D 0
>> ...
>> }
>>
>> so, vidioc_reqbufs->videobuf_reqbufs() will always fail.
>>
>> Do you agree with me?
>>
>> Thanks & Best Regards,
>> George.Qiao
>>
>> =EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=
=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=
=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=
=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=
=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D
>>    =20
>>>> -----Original Message-----
>>>> From: George.Qiao [mailto:qiao_shanshan@visualon.com]
>>>> Sent: Friday, May 08, 2009 11:57 AM
>>>> To: Hiremath, Vaibhav
>>>> Cc: Syed Mohammed, Khasim; Shah, Hardik; wan_jinxue@visualon.com;
>>>> Bill Lin; shawnofarrell@visualon.com; Chatterjee, Amit; Andrews,
>>>> Gerard; Kridner, Jason; 'Bangfei Jin'; 'Xuejun Dong'; 'YangCai';
>>>> linux-omap@vger.kernel.org
>>>> Subject: Re: Status of Beagle Board
>>>>
>>>> Hi Vaibhav Hiremath,
>>>>
>>>> My application can work in OMAP3 EVM and other v4l2 platform, but
>>>> there
>>>> is another issue in beagle board. as follow:
>>>>
>>>>
>>>>        =20
>>> [Hiremath, Vaibhav] Are you saying, same application works on
>>>      =20
>> OMAP3EVM but fails on beagle board?
>>    =20
>>>      =20
>>>> 1. NormalSize() -> RequestBuffer() -> mmap()
>>>> 2. playing...
>>>> 3. FullScreen() -> VIDIOC_STREAMOFF
>>>>                           -> munmap()
>>>>                           -> VIDIOC_REQBUFS
>>>>                           -> VIDIOC_QUERYBUF
>>>>                           -> RequestBuffer() -> mmap()
>>>>                           -> VIDIOC_S_CROP
>>>>                           -> VIDIOC_S_FMT
>>>>                           -> VIDIOC_QBUF
>>>>                           -> VIDIOC_STREAMON
>>>>
>>>> When I want to call VIDIOC_REQBUFS in FullScreen(), it always
>>>>        =20
>> fail.
>>    =20
>>>>        =20
>>> [Hiremath, Vaibhav] Is it possible for you to share your
>>>      =20
>> application, so that I can give try here at my end?
>>    =20
>>> Thanks,
>>> Vaibhav Hiremath
>>>
>>>
>>>      =20
>>>> Best Regards,
>>>> George.Qiao
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>>
>>>>        =20
>>>>> Great, please see my comments in-lined below -
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Vaibhav Hiremath
>>>>> Platform Support Products
>>>>> Texas Instruments Inc
>>>>> Ph: +91-80-25099927
>>>>>
>>>>>
>>>>>
>>>>>          =20
>>>>>> -----Original Message-----
>>>>>> From: George.Qiao [mailto:qiao_shanshan@visualon.com]
>>>>>> Sent: Thursday, May 07, 2009 3:51 PM
>>>>>> To: Hiremath, Vaibhav
>>>>>> Cc: Syed Mohammed, Khasim; Shah, Hardik;
>>>>>>            =20
>> wan_jinxue@visualon.com;
>>    =20
>>>>>> Bill Lin; shawnofarrell@visualon.com; Chatterjee, Amit;
>>>>>>            =20
>> Andrews,
>>    =20
>>>>>> Gerard; Kridner, Jason; 'Bangfei Jin'; 'Xuejun Dong';
>>>>>>            =20
>> 'YangCai';
>>    =20
>>>>>> linux-omap-open-source@linux.omap.com
>>>>>> Subject: Re: Status of Beagle Board
>>>>>>
>>>>>> Dear Vaibhav Hiremath,
>>>>>>
>>>>>> I can play video by v4l2 now!  Thank you!
>>>>>>
>>>>>> I have add code in board-omap3beagle.c :
>>>>>>
>>>>>> #ifdef CONFIG_FB_OMAP2
>>>>>> static struct resource omap3beagle_vout_resource[3 -
>>>>>> CONFIG_FB_OMAP2_NUM_FBS] =3D {
>>>>>> };
>>>>>> #else
>>>>>> static struct resource omap3beagle_vout_resource[2] =3D {
>>>>>> };
>>>>>> #endif
>>>>>>
>>>>>> static struct platform_device omap3beagle_vout_device =3D {
>>>>>>        .name                   =3D "omap_vout",
>>>>>>        .num_resources  =3D ARRAY_SIZE(omap3beagle_vout_resource)=
,
>>>>>>        .resource               =3D &omap3beagle_vout_resource[0]=
,
>>>>>>        .id             =3D -1,
>>>>>> };
>>>>>>
>>>>>> static struct platform_device *omap3_beagle_devices[]
>>>>>>            =20
>> __initdata
>>    =20
>>>> =3D {
>>>>
>>>>        =20
>>>>>>     &beagle_dss_device,
>>>>>>     &leds_gpio,
>>>>>>     &keys_gpio,
>>>>>>     &omap3beagle_vout_device,
>>>>>> };
>>>>>>
>>>>>>
>>>>>> I have got some omapdss error and voutBuffer Size. as follow:
>>>>>>
>>>>>> omapdss: Could not find exact pixel clock. Requested 23500 kHz,
>>>>>>
>>>>>>            =20
>>>> got
>>>>
>>>>        =20
>>>>>> 24000 kHz
>>>>>> omapdss error: display already enabled
>>>>>> omap_voutDisplay already enabled
>>>>>> omapdss error: display already enabled
>>>>>> omap_voutDisplay already enabled
>>>>>>
>>>>>>
>>>>>>            =20
>>>>> [Hiremath, Vaibhav] This is not an error as such, it warning
>>>>>
>>>>>          =20
>>>> message. Actually here we are trying to enable the display which
>>>>        =20
>> has
>>    =20
>>>> already been enabled by Fbdev.
>>>>
>>>>        =20
>>>>> We can suppress this message, atleast during init.
>>>>>
>>>>>
>>>>>
>>>>>          =20
>>>>>> omap_voutBuffer Size =3D 3686400
>>>>>> omap_vout: registered and initialized video device 0 [v4l2]
>>>>>> omap_voutBuffer Size =3D 3686400
>>>>>> omap_vout: registered and initialized video device 1 [v4l2]
>>>>>>
>>>>>>
>>>>>>
>>>>>>            =20
>>>>> [Hiremath, Vaibhav] This is just a debug massage; it is neither
>>>>>          =20
>> a
>>    =20
>>>> error nor a warning. So don't worry.
>>>>
>>>>        =20
>>>>> Can you share the code-base or submit the patches to the list,
>>>>>          =20
>> so
>>    =20
>>>> that interested people can use it.
>>>>
>>>>        =20
>>>>>> Could I change 'voutBuffer Size'?  How to fix it?
>>>>>>
>>>>>> Best Regards,
>>>>>> George.Qiao
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>>>>
>>>>>>
>>>>>>            =20
>>>>>>> Yes Definitely this is the issue. If the platform_device.name
>>>>>>>
>>>>>>>
>>>>>>>              =20
>>>>>> doesn't match with the platform_driver.driver.name then your
>>>>>>
>>>>>>            =20
>>>> probe
>>>>
>>>>        =20
>>>>>> function will not be called at all.
>>>>>>
>>>>>>
>>>>>>            =20
>>>>>>> Can you just copy the board-omap3evm.c changes related to
>>>>>>>
>>>>>>>
>>>>>>>              =20
>>>>>> V4L2/DSS2 and give a shot? I think it should work straight
>>>>>>            =20
>> away.
>>    =20
>>>>>>            =20
>>>>>>> Please let me know if you need any further clarification or
>>>>>>>
>>>>>>>              =20
>>>> help.
>>>>
>>>>        =20
>>>>>>> Thanks,
>>>>>>> Vaibhav Hiremath
>>>>>>> Platform Support Products
>>>>>>> Texas Instruments Inc
>>>>>>> Ph: +91-80-25099927
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>              =20
>>>>>>>> -----Original Message-----
>>>>>>>> From: George.Qiao [mailto:qiao_shanshan@visualon.com]
>>>>>>>> Sent: Thursday, May 07, 2009 12:55 PM
>>>>>>>> To: Hiremath, Vaibhav
>>>>>>>> Cc: Syed Mohammed, Khasim; Shah, Hardik;
>>>>>>>>
>>>>>>>>                =20
>>>> wan_jinxue@visualon.com;
>>>>
>>>>        =20
>>>>>>>> Bill Lin; shawnofarrell@visualon.com; Chatterjee, Amit;
>>>>>>>>
>>>>>>>>                =20
>>>> Andrews,
>>>>
>>>>        =20
>>>>>>>> Gerard; Kridner, Jason; 'Bangfei Jin'; 'Xuejun Dong';
>>>>>>>>
>>>>>>>>                =20
>>>> 'YangCai';
>>>>
>>>>        =20
>>>>>>>> linux-omap-open-source@linux.omap.com
>>>>>>>> Subject: Re: Status of Beagle Board
>>>>>>>>
>>>>>>>> Hi Hiremath, Vaibhav,
>>>>>>>>
>>>>>>>> Thank you very much for your instant response!
>>>>>>>>
>>>>>>>> I've checked the file 'board-omap3beagle.c' and found nothing
>>>>>>>> looking
>>>>>>>> like omap_vout in it, no platform_device, either. And I've
>>>>>>>>                =20
>> also
>>    =20
>>>>>>>> compared
>>>>>>>> it with board-omap3evm.c.
>>>>>>>>
>>>>>>>> Below is some difference between them:
>>>>>>>>
>>>>>>>> board-omap3evm.c has:
>>>>>>>> *+static struct platform_device omap3evm_vout_device =3D {
>>>>>>>> **+       .name                   =3D "omap_vout",
>>>>>>>> ...
>>>>>>>> }
>>>>>>>> *
>>>>>>>> But 'board-omap3beagle.c' does not have anything looking
>>>>>>>>                =20
>> like:
>>    =20
>>>>>>>> *+static struct platform_device omap3beagle_vout_device =3D {*
>>>>>>>> *+       .name                   =3D "omap_vout",
>>>>>>>> ...
>>>>>>>> }
>>>>>>>> *
>>>>>>>> So, I think there's no patch on V4L2 for beagle done and this
>>>>>>>>
>>>>>>>>                =20
>>>> is
>>>>
>>>>        =20
>>>>>> the
>>>>>>
>>>>>>
>>>>>>            =20
>>>>>>>> root cause of this issue. Do you agree with me? Thanks a lot.
>>>>>>>>
>>>>>>>>
>>>>>>>> Best Regards,
>>>>>>>> George.Qiao
>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>                =20
>>>>>>>>> Hi George,
>>>>>>>>>
>>>>>>>>> I have looked into your config file and it looks ok to me.
>>>>>>>>>
>>>>>>>>> Can you conform that, you have added "platform_device"
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>                  =20
>>>>>> definitions
>>>>>>
>>>>>>
>>>>>>            =20
>>>>>>>> in board-omap3beagle.c?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>                =20
>>>>>>>>> Can you please create complete patch on top of your baseline
>>>>>>>>>
>>>>>>>>>                  =20
>>>> (O-
>>>>
>>>>        =20
>>>>>> L
>>>>>>
>>>>>>
>>>>>>            =20
>>>>>>>> and Tomi's tree), so that I can review that directly? I will
>>>>>>>>                =20
>> be
>>    =20
>>>>>>>> seeing complete changes done for beagle.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>                =20
>>>>>>>>> Thanks,
>>>>>>>>> Vaibhav Hiremath
>>>>>>>>> Platform Support Products
>>>>>>>>> Texas Instruments Inc
>>>>>>>>> Ph: +91-80-25099927
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>                  =20
>>>>>          =20
>>>
>>>      =20
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
