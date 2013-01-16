From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 13:11:26 +0200
Message-ID: <50F68ADE.9020400@compulab.co.il>
References: <20130109092915.1c2077b5@notabene.brown> <50ED3FA5.9030905@compulab.co.il> <20130109211931.0e00db5d@notabene.brown> <50ED4549.6080802@amarulasolutions.com> <20130109223456.7832c2bd@notabene.brown> <50ED5DBE.4000107@amarulasolutions.com> <50ED6868.1080900@compulab.co.il> <20130116182606.5249db0c@notabene.brown> <50F672A2.6010500@compulab.co.il> <20130116211927.42195d3b@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:47590 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292Ab3APLLe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 06:11:34 -0500
In-Reply-To: <20130116211927.42195d3b@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/16/13 12:19, NeilBrown wrote:
> On Wed, 16 Jan 2013 11:28:02 +0200 Igor Grinberg <grinberg@compulab.c=
o.il>
> wrote:
>=20
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>=20
>> On 01/16/13 09:26, NeilBrown wrote:
>>> On Wed, 09 Jan 2013 14:54:00 +0200 Igor Grinberg <grinberg@compulab=
=2Eco.il>
>>> wrote:
>>>
>>>> On 01/09/13 14:08, Michael Trimarchi wrote:
>>>>> Hi Neil
>>>>>
>>>>> I forget to answer to your questions
>>>>>
>>>>> On 01/09/2013 12:34 PM, NeilBrown wrote:
>>>>>> On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
>>>>>> <michael@amarulasolutions.com> wrote:
>>>>>>
>>>>>>> Hi Neil
>>>>>>>
>>>>>>> On 01/09/2013 11:19 AM, NeilBrown wrote:
>>>>>>>> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@com=
pulab.co.il>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>>>> Hash: SHA1
>>>>>>>>
>>>>>>>>> Hi Neil,
>>>>>>>>
>>>>>>>>> On 01/09/13 00:29, NeilBrown wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>  I'm trying to get off_mode working reliably on my gta04 mob=
ile phone.
>>>>>>>>>>
>>>>>>>>>> My current stumbling block is USB.  The "Option" GSM module =
is attached via
>>>>>>>>>> USB (there is a separate transceiver chip attached to port 1=
 which is placed
>>>>>>>>>> in OMAP_EHCI_PORT_MODE_PHY).
>>>>>>>>
>>>>>>>>> Which PHY is this (vendor/model)?
>>>>>>>>
>>>>>>>> Hi Igor,
>>>>>>>>   it is the SMSC USB3322
>>>>>>>>
>>>>>>>> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pd=
f
>>>>>>>>
>>>>>>>>
>>>>>>>> BTW I subsequently discovered that keeping USBHOST out off off=
_mode only
>>>>>>>> sometimes avoid the problem, not always.  So there are probabl=
y multiple
>>>>>>>> issues :-(
>>>>
>>>> We have the same PHY and it has some issues with the OMAP USB code=
=2E
>>>> First issue we experience is that if we reset the PHY more then on=
ce
>>>> w/o power cycling it, the PHY dies until next power cycle.
>>>> So, we stop providing the reset GPIO to the usb code and do the re=
set
>>>> in the board code.
>>>
>>> I've tried various change w.r.t the resetting and  I cannot fault i=
t.
>>> Resetting or not resetting neither causes a problem while the USB i=
s
>>> otherwise working, not fixed the USB while  it is otherwise failing=
=2E
>>> So I don't think this is my problem - thanks.
>>>
>>>>
>>>>>>>
>>>>>>> Are you sure that you don't have glitch on power, reset pin dur=
ing suspend?
>>>>>>>
>>>>>>
>>>>>> No, I don't really have the equipment to measure such things.
>>>>>> But is it likely?  Would enabling off_mode make it more likely?
>>>>>
>>>>> I don't know the reason of the off_mode problem :(
>>>>
>>>> We have the equipment to check this and no - this is not the case.
>>>>
>>>>>
>>>>>> Can you suggest some way I could test the hypothesis?
>>>>>
>>>>> I had the same problem on a rugged mobile phone, so it is just ex=
perience
>>>>> Check the modem power and reset gpio too, but if you don't need t=
o unblock it
>>>>> with the pin after resume we know that modem is not the problem
>>>>
>>>> I don't think modem is the problem...
>>>> We have plain USB connector ports that are dead after the resume f=
rom off-mode.
>>>>
>>>> The good news are that we have the off-mode working on v3.6.1,
>>>> including the USB, but we had to do some horrible ugly hacking for=
 this.
>>>>
>>>
>>> I assume this  means "some patches on top of 3.6.1" ??
>>> Care to share your code?  Even horribly ugly hacks can be education=
al.
>=20
>> We are not ready to share these patches (this will happen eventually
>> after some work is finished), but I can explain what they do...
>=20
>> We split the ehci_run function to separate the debugfs and sysfs stu=
ff from
>> other initializations, so we can run the new version without the deb=
ugfs and
>> sysfs stuff multiple times.
>=20
>> Then we implement the suspend/resume ehci callbacks:
>> on suspend, assert phy reset,
>> on resume, deassert phy reset, write EHCI_INSNREG04_DISABLE_UNSUSPEN=
D to
>> EHCI_INSNREG04, and call the new ehci_run() function.
>=20
>> That does the job for USB host to resume from off mode.
>=20
> Interesting thanks.  That makes a certain amount of sense.
>=20
> However I tried compiling ehci-hcd as a module and  unload/reloading =
it which
> should have a similar net effect to what you did, but it didn't make =
any
> difference - device disappears on resume.

Yes it does for cm-t3730, in fact, that is what we have started from...

>=20
> I also tried restoring the correct value to EHCI_INSNREG04 and
> EHCI_INSNREG05_ULPI which are the only registers written by=20
> ehci-omap.c, and that didn't help either.
>=20
> The only thing I've found that works is keeping 'core' out of off-mod=
e.

Ah, one more thing, we ensure that phy is completely powered off throug=
h
the TPS power scripts, otherwise, it does not work...

>=20
> BTW I discovered that arch/arm/mach-omap2/powerdomains3xxx_data.c
> comments out the setting of=20
>   .flags    =3D PWRDM_HAS_HDWR_SAR,
> for the usbhost powerdomain - that is why I had to leave it in retent=
ion.
> If I uncomment that setting, the it is safe for USBHOST to go to off-=
mode,
> just not for CORE.
>=20
> I'll keep exploring.
>=20
> NeilBrown
> N?=A7=B2=E6=ECr=B8?y=FA=E8?=D8b=B2X=AC=B6=C7=A7v=D8^?)=DE=BA{.n=C7+?=B7=
=A5?{=B1=A2f=A9?{ay=BA=1D=CA?=DA?=EB,j=07=AD=A2f=A3=A2=B7h??=E0z=B9=1E=AE=
w=A5=A2=B8=0C=A2=B7=A6j:+v?=A8?w=E8j=D8m=B6?=FF=BE=07=AB?=EA=E7zZ+?=F9?=
??=DD=A2j"?=FA!tml=3D

- --=20
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQ9oreAAoJEBDE8YO64EfaRasP/iUDBXhmPQtVm7ESB1DPopMc
b5dUWY1mwQGfNhdcPqApyPk5MPzHTAFfNiLTxJURUqN562gMl1+SR4Mr9cOX6ju4
ahlxyciOlb2KzsCTAUC9PPJVQSR2UbAPMZIA84B4pt6GOYF0OVHzFDickFhAg7Nu
dvnpMyE1gNTCISAi28lp6pLY5POcyo4HAeZaapPrl3G1GbivplKH+AqJLLeVoJzA
InebBUBe1lCDZ31RyY8uiTjjr8Qc+JDzSLybKkuijULwXualJDaJjRxvfG9cfoju
3v+/HvVdAJzqTN9cdQBJJ3VLAhpLZJHKvSlQ3K8IYLHaG5K4QJsrf6WZldRIPaAe
Ztv5EdKK3l2e4nbTP3oJmU56R2XREcKltw8e1XWNkpnN6sKn6sx8iuVPCeFlb/SA
snA1i9gkvQWRnKeW7At2Jiv3C3Xn9L+1fulYzTjk/mX+P4sKhigllV73naAeGnZZ
GOa7F1FeCq0L8d2CV36FWwXOvOqdyrkgCabA2GQrOHlIOjnOqhymc/pybGGly1Ph
arGUSdcFdl1rxcuzIYcBKgV8eF5E+wjnLMVubO/Bj9nrpbxVAeyAyF0qNY1RWmBx
oY5JJah2EM/AyPBKCSEY3PBugwAFLPV9uL69Bw0rJbxfT1uWBHVoby3Q5/dpWAJv
bt+zpdKaK5n3KYHqbPci
=3DqbkL
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
