From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Sun, 1 Apr 2012 21:20:58 +0200
Message-ID: <CAAwP0s30z1DkfnTH0WE7S9m9t3iQuvKc+C_okrtzLFpN0gKhgw@mail.gmail.com>
References: <4F6324D5.9010106@uni-dortmund.de> <20120316193337.GE7276@atomide.com>
 <4F675D9D.2040102@uni-dortmund.de> <20120319225131.GE9859@atomide.com>
 <4F6893C6.60701@uni-dortmund.de> <CAAwP0s3Qo7vtt=BY7Pvejg4Gc9X0O0n=yWg0JVGZHrmUJScMXw@mail.gmail.com>
 <4F75D136.5020208@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59868 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2DATVT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Apr 2012 15:21:19 -0400
Received: by gghe5 with SMTP id e5so964578ggh.19
        for <linux-omap@vger.kernel.org>; Sun, 01 Apr 2012 12:21:18 -0700 (PDT)
In-Reply-To: <4F75D136.5020208@uni-dortmund.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Klute <thomas2.klute@uni-dortmund.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Mar 30, 2012 at 5:28 PM, Thomas Klute
<thomas2.klute@uni-dortmund.de> wrote:
> Hi,
>
> I finally had some time to do more tests on this problem. Findings be=
low.
>

Great, I guess we are close to find the issue :)

> Am 20.03.2012 20:47, schrieb Javier Martinez Canillas:
>> On Tue, Mar 20, 2012 at 3:27 PM, Thomas Klute
>> <thomas2.klute@uni-dortmund.de> wrote:
>>> Am 19.03.2012 23:51, schrieb Tony Lindgren:
>>>> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120319 09:26]:
>>>>> Am 16.03.2012 20:33, schrieb Tony Lindgren:
>>>>>> Hi,
>>>>>>
>>>>>> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120316 05:08]:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I have trouble getting the Ethernet port on a Gumstix Overo wit=
h Tobi
>>>>>>> expansion board to work with current kernel versions. With the =
latest
>>>>>>> commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11fac=
ec2aa),
>>>>>>> the output from loading the smsc911x driver is as follows:
>>>>>>>
>>>>>>> du14:~# modprobe smsc911x
>>>>>>> [ =C2=A0254.843811] smsc911x: Driver version 2008-10-21
>>>>>>> [ =C2=A0254.854553] smsc911x: Driver version 2008-10-21
>>>>>>> [ =C2=A0254.859588] _regulator_get: smsc911x.1 supply vdd33a no=
t found, using
>>>>>>> dummy regulator
>>>>>>> [ =C2=A0254.868377] _regulator_get: smsc911x.1 supply vddvario =
not found,
>>>>>>> using dummy regulator
>>>>>>>
>>>>>>> "ip link show" does not show any available Ethernet port.
>>>>>>
>>>>>> The first instance one should work the same way as earlier using
>>>>>> fixed regulator in gpmc-smsc911x.c. Is it not working for you
>>>>>> somehow? At least it works for me on zoom3.
>>>>>
>>>>> The Tobi board has only one Ethernet port.
>>>>>
>>>>>>> I know there has been some trouble with changes around smsc911x
>>>>>>> regulator support and Gumstix Overo in particular. Am I just mi=
ssing the
>>>>>>> right regulator in my kernel config or is this a bug? I can tes=
t patches
>>>>>>> in the latter case.
>>>>>>
>>>>>> The second smsc911x now needs a regulator. For multiple smsc911x=
 instances,
>>>>>> we should change things around so no regulator is created if one
>>>>>> is passed.
>>>>>>
>>>>>> Care to test the following patch by passing a fixed regulator
>>>>>> from board-overo.c?
>>>>>
>>>>> After applying the patch the Ethernet port works consistently onc=
e I had
>>>>> done a cold boot (reboot from the unpatched kernel did not work).
>>>>> Thank you!
>>>>
>>>> Hmm but this patch should not change the behaviour for the first s=
msc911x
>>>> instance unless you specify a custom regulator.. Did you patch in =
a
>>>> custom regulator, or do we have a bug somewhere? Or do you just ne=
ed to
>>>> do a cold reset without the patch I posted?
>>>
>>> You're right, during further tests I found that the problem lies
>>> elsewhere: If the Ethernet cable is attached on modprobe, the devic=
e
>>> works as expected, if not, it's not found (with or without the patc=
h).
>>> This means if I boot with the cable disconnected, the device won't =
show
>>> up, but after
>>>
>>> # modprobe -r smsc911x
>>> [attach cable]
>>> # modprobe smsc911x
>>>
>>> it will work. I'd still consider this a bug, but it doesn't seem to=
 be a
>>> regulator problem.
>>>
>>
>> Hi Thomas,
>>
>> I had the same behavior with the smsc911x chip but on an IGEPv2 boar=
d.
>> The problem was when CONFIG_SMSC_PHY=3Dy since the driver for the ch=
ip
>> internal PHY enables an energy detect power-down mode.
>>
>> The smsc911x driver probe function tries to software reset the chip
>> but if the cable is unplugged the energy detect puts the chip in a l=
ow
>> power mode. Since the chip is not in an operational state the reset
>> fails and hence the driver probe function. If the cable is plugged
>> then then energy is detected, the chip is in an operational state an=
d
>> the reset is successful.
>>
>> I sent a patch a few months ago to fix this issue. The patch disable=
s
>> the energy detect power-down mode before reseting the chip and then =
it
>> enables again after reset.
>>
>> The commit is:
>>
>> commit 6386994e03ebbe60338ded3d586308a41e81c0dc
>> Author: Javier Martinez Canillas <javier@dowhile0.org>
>> Date: =C2=A0 Tue Jan 3 13:36:19 2012 +0000
>>
>> =C2=A0 =C2=A0 net/smsc911x: Check if PHY is in operational mode befo=
re software reset
>>
>> When I fix the issue I only guarded against generation 4 chips (i.e:
>> pdata->generation =3D=3D 4), but maybe this problem also exists in o=
ther
>> SMSC chips (I didn't know since I only had access to specific
>> data-sheets).
>>
>> Also you can try enabling debug in the driver by setting USE_DEBUG t=
o
>> 1 in drivers/net/ethernet/smsc/smsc911x.h and also trying disabling
>> CONFIG_SMSC_PHY, this will use a generic PHY driver that doesn't put
>> the chip in auto power mode.
>
> After looking at the code I set USE_DEBUG to 3 to get as much
> information as possible and tested with and without the SMSC PHY driv=
er.
> Results:
>
> With the Ethernet cable attached, the device is properly initialized
> with and without the PHY driver (as before).
>
> Without the cable, the smsc911x driver can initialize the card only i=
f
> the smsc PHY driver had not been loaded previously. Unloading the PHY
> driver is not enough, even a reboot doesn't help. I have to do a cold
> boot (or attach the cable).
>

This makes sense since is the PHY driver who enables the auto energy
detect mode.

> I guess this confirms Javier's guess, but there's one catch: If you t=
ake
> a look at the attached logs (both without cable attached), you'll see
> that the device is recognized a generation 4, so the Javier's workaro=
und
> should actually be used. I added a log output in the if
> (pdata->generation =3D=3D 4) block to be sure, and indeed it is used.
>
> Any hints why the reset still fails?
>
> Regards,
> Thomas

My guess is that the PHY chip is still in a low power down and not
being woken up before the MAC chip is tried to be software reseted. I
didn't find in the SMSC LAN8700 data-sheet how long it takes to wake
up the chip and probably it depends of the PHY chip (I only tried with
the 8700) so if I were you I would try increasing the delay time after
sending the MII command to disable the auto energy detect mode.

Can you try this patch?

diff --git a/drivers/net/ethernet/smsc/smsc911x.c
b/drivers/net/ethernet/smsc/smsc911x.c
index 24d2df0..d08709a 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -1349,7 +1349,7 @@ static int
smsc911x_phy_disable_energy_detect(struct smsc911x_data *
                        return rc;
                }

-               mdelay(1);
+               mdelay(100);
        }

        return 0;


Best regards,
--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
