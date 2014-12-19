From: Eduard Gavin <egavin-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Fri, 19 Dec 2014 12:16:04 +0100
Message-ID: <CAPjucKaEodpFtv533az+axecjsOahDsWV=V-M6sX84Z27KovsQ@mail.gmail.com>
References: <CAJt7siu_JiSe3CfM2=0UZLQjRevdLuX+=UL566fiW6XefTTWGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJt7siu_JiSe3CfM2=0UZLQjRevdLuX+=UL566fiW6XefTTWGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Agust=C3=AD_Fontquerni?= <af-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Everybody,

After several test with IGEPv2 board (OMAP3) and linux kernel 3.17 and
3.18, the OTG works but, (from my point of view) with an weird
behaviour.

The OTG like a Host only is activated after load a gadget driver, I
mean that, If I plug a USB memory dongle in the OTG port before load a
Gadget driver like "g_ether" the dongle is not recognized. After load
g_ether driver, the usb dongle is recognized without problems.
I miss something in the configuration?
It this the normal behaviour?
Best Regards
Eduard

2014-12-17 11:18 GMT+01:00 Agust=C3=AD Fontquerni <af-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>:
>
> Hi everybody,
>
> We are working on IGEPv2 board about OTG issue.
>
> 2014-11-19 18:53 GMT+01:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>>
>> * Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141119 03:14]:
>> > 2014-11-18 16:42 GMT+01:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>> >
>> > Checked again, and no luck. It's very weird because from the OTG p=
oint
>> > of view, OTG is exactly the same between Beagleboard-XM and IGEPv2=
=2E
>> >
>> > Can you confirm that you're using kernel 3.18-rc5 without other
>> > patches applied ? At this moment, I don't have a Beagleboard-XM to
>> > test, I'll try to get one because at this moment I'm a bit stuck w=
ith
>> > this problem.
>>
>> Yes it was with v3.18-rc5 and the defconfig patch I posted except
>> I had to disable all the other MUSB platforms. Also tested it with
>> built in modules.
>>
>> Maybe you need to check the .dts pinctrl entries for hsusb0_* lines?
>
>
>  Command "root@arm:/sys/kernel/debug/pinctrl# cat pinctrl-maps | grep=
 -5
> usb" reports:
>
>  device 480025a0.pinmux
>  state default
>  type MUX_GROUP (2)
>  controlling device 480025a0.pinmux
>  group pinmux_hsusbb1_pins
>  function pinmux_hsusbb1_pins
>
>  So, I think that is needed configure usb0 in lastest "omap3-igep0020=
=2Edts"
>
>  Moreover, in old 2.6.37 kernel, we saw omap_mux pin configuration in
> "/sys/kernel/debug/omap_mux/hsusb0_xxx".
> Now in newer 3.1x kernels, Where could it read omap_mux pin configura=
tion ?
>
>>
>> Regards,
>>
>> Tony
>>
>
>  Best Regards,
>  Agusti Fontquerni
>



--=20
Eduard Gavin Carulla

e: egavin-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org

t: +34 935 763 931

t: +34 935 763 932

www.isee.biz

C/ Marcos Redondo, 5 Valldoreix CP. 08197 (Barcelona) - Spain

 Important notice: This message and any files transmitted with it are
confidential and intended solely for the individual to whom it is
addressed. Unauthorized publication, use, dissemination, forwarding,
printing or copying of this email and its associated attachments is
strictly prohibited. If you have received this email in error, please
notify the sender and delete the original immediately. Thank you for
your cooperation.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
