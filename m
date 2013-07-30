From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: remove *.auto* from device names given
 in usb_bind_phy
Date: Tue, 30 Jul 2013 12:16:20 +0530
Message-ID: <51F7613C.5070803@ti.com>
References: <1374829418-27503-1-git-send-email-kishon@ti.com> <1374829418-27503-3-git-send-email-kishon@ti.com> <20130729150638.GD3063@radagast> <51F68A56.8060805@ti.com> <20130729175413.GC4964@radagast> <51F74BC8.7020903@ti.com> <20130730060134.GD9155@radagast> <51F7590B.4020705@ti.com> <20130730061830.GE9155@radagast> <51F75C40.4060406@ti.com> <20130730062844.GH9155@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130730062844.GH9155@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 30 July 2013 11:58 AM, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Jul 30, 2013 at 11:55:04AM +0530, Kishon Vijay Abraham I wrot=
e:
>>> On Tue, Jul 30, 2013 at 11:41:23AM +0530, Kishon Vijay Abraham I wr=
ote:
>>>>>>>>>> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/=
mach-omap2/board-2430sdp.c
>>>>>>>>>> index 244d8a5..17bb076 100644
>>>>>>>>>> --- a/arch/arm/mach-omap2/board-2430sdp.c
>>>>>>>>>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
>>>>>>>>>> @@ -233,7 +233,7 @@ static void __init omap_2430sdp_init(voi=
d)
>>>>>>>>>>  	omap_hsmmc_init(mmc);
>>>>>>>>>> =20
>>>>>>>>>>  	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PU=
LL_UP);
>>>>>>>>>> -	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>>>>>>>>>> +	usb_bind_phy("musb-hdrc.0", 0, "twl4030_usb");
>>>>>>>>>
>>>>>>>>> how about moving usb_bind_phy() calls to omap2430.c ?
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/o=
map2430.c
>>>>>>>>> index f44e8b5..b6abc1a 100644
>>>>>>>>> --- a/drivers/usb/musb/omap2430.c
>>>>>>>>> +++ b/drivers/usb/musb/omap2430.c
>>>>>>>>> @@ -544,6 +544,9 @@ static int omap2430_probe(struct platform=
_device *pdev)
>>>>>>>>> =20
>>>>>>>>>  		pdata->board_data	=3D data;
>>>>>>>>>  		pdata->config		=3D config;
>>>>>>>>> +	} else {
>>>>>>>>> +		/* bind the PHY */
>>>>>>>>> +		usb_bind_phy(dev_name(&musb->dev), 0, "twl4030_usb");
>>>>>>>>
>>>>>>>> This looks like a hack IMHO to workaround the usb phy library.=
 otherwise it is
>>>>>>>> similar to get_phy_by_name.
>>>>>>>
>>>>>>> actually, this is a workaround to the fact that we're not creat=
ing all
>>>>>>> platform_devices in arch/arm/mach-omap2/ :-)
>>>>>>>
>>>>>>> If we had the musb allocation there, we could easily handle
>>>>>>> usb_bind_phy()
>>>>>>>
>>>>>>>>> so that's temporary. It might be better than to reintroduce t=
he IDR in
>>>>>>>>> musb_core.c.
>>>>>>>>
>>>>>>>> that=E2=80=99s needed for generic phy framework anyway :-s
>>>>>>>
>>>>>>> right, but generic phy framework can handle everything just fin=
e, the
>>>>>>> only problem is that names are changing.
>>>>>>
>>>>>> right. But if the names change, PHY framework wouldn't be able t=
o return the
>>>>>> reference to the PHY.
>>>>>
>>>>> with my suggestion they can change whenever they want since we're=
 using
>>>>> dev_name() of the just-created musb platform_device. Right ?
>>>>
>>>> right. But the PHY device can be created in a different place from=
 where the
>>>> musb devices are created. And in the PHY framework, the PHY device=
 should have
>>>
>>> this shouldn't be a problem. As long as the phy is created, all sho=
uld
>>> be good.
>>>
>>>> the list of controller device (names) it can support (PHY framewor=
k does not
>>>> maintain a separate list for binding like how we had in USB PHY li=
brary). e.g.
>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92817.ht=
ml. In such
>>>
>>> this has nothing to do with $subject though. We talk about generic =
PHY
>>> framework once all these PHY drivers are moved there :-)
>>>
>>>> cases how do we pass the device names. Also will the MUSB core dev=
ice be
>>>> created before twl4030-usb PHY device?
>>>
>>> and why would that be a problem ? We're telling the framework that =
the
>>> musb device will use a phy with a name of 'twl4030'. If musb calls
>>> usb_get_phy_dev() and doesn't find a phy, it'll return -EPROBE_DEFE=
R and
>>> try again later.
>>
>> I think we are talking about different problems here ;-) I'm trying =
to tell
>> using idr in MUSB core is needed for Generic PHY Framework. So in a =
way, the
>> Generic PHY Framework series depends on this patch series or else MU=
SB in OMAP3
>> platforms wont work after Generic PHY framework gets merged.
>=20
> then you just found a limitation in your framework, right ? :-) I mea=
n,
> imagine if now we have to add an IDR to every single user of your
> framework because they could end up in systems with multiple instance=
s
> of the same IP ?

I raised a similar concern in the PHY framework discussion [1] :-) And =
since
it's used everywhere else regulators, clkdev, etc.. it's agreed to be u=
sed in
PHY as well. Btw if PLATFORM_DEVID_AUTO is used even regulator, clk_get=
 should
fail IMO.

[1] -> http://lkml.indiana.edu/hypermail/linux/kernel/1307.2/03573.html

Thanks
Kishon
