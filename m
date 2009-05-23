From: Andrew de Quincey <adq@lidskialf.net>
Subject: Re: Tracking N770 breakage
Date: Sat, 23 May 2009 12:30:40 +0100
Message-ID: <20090523123040.16971ty5wndy6mow@lidskialf.net>
References: <20090516140653.10104565olvxrwjk@lidskialf.net>
	<20090517031715.92503qopn0joudhc@lidskialf.net>
	<20090519231500.GM19742@atomide.com>
	<20090520061544.560957looc5zgav4@lidskialf.net>
	<20090520151907.GC8308@atomide.com>
	<20090522184720.10616mt8vpjglk3k@lidskialf.net>
	<20090522193359.17514ptwyl8kdbls@lidskialf.net>
	<20090522231826.12833dwwkvi7rv0g@lidskialf.net>
	<20090523023901.33341jpwcx6nd70g@lidskialf.net>
	<20090523014717.GB9283@atomide.com>
	<20090523121108.14776dli2aeyapkw@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_1scpxcsblm5c"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:45546 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZEWLaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 07:30:39 -0400
In-Reply-To: <20090523121108.14776dli2aeyapkw@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, ladis@linux-mips.org

This message is in MIME format.

--=_1scpxcsblm5c
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:

> Quoting Tony Lindgren <tony@atomide.com>:
>
>> * Andrew de Quincey <adq@lidskialf.net> [090522 18:39]:
>>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>>
>>>> Quoting Andrew de Quincey <adq@lidskialf.net>:
>>>>
>>>>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>>>>
>>>>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>>>>
>>>>>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090519 22:15]:
>>>>>>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>>>>>>
>>>>>>>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
>>>>>>>>>> Argh, my N770 seems to have just died; it has been behaving sligh=
tly
>>>>>>>>>> oddly and now it simply won't turn on (black screen and no =20
>>>>>>>>>> sign of life
>>>>>>>>>> whatsoever).
>>>>>>>>>>
>>>>>>>>>> It is well out of warranty and frankly I don't see myself
>>>>>>>>>> buying another
>>>>>>>>>> one, so this effectively ends my hacking on it :(
>>>>>>>>>
>>>>>>>>> Bummer :(
>>>>>>>>>
>>>>>>>>> After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first =20
>>>>>>>>> stopper, then
>>>>>>>>> it could not mount the MMC root.
>>>>>>>>
>>>>>>>> Ahh excellent, that was why I posted my progress, in case it =20
>>>>>>>> rang a bell
>>>>>>>> with anyone! I think the touchpad driver may be broken as well BTW.
>>>>>>>>
>>>>>>>>> I think there was a patch posted for the omap1 MMC by
>>>>>>>>> Ladislav few months
>>>>>>>>> ago that probably fixes it.
>>>>>>>>
>>>>>>>> Cool - I hope I may be back in the running soon (I was rather annoy=
ed
>>>>>>>> when I posted that message!); I've ordered a new battery in case it=
s
>>>>>>>> just that. A kind person has also offered me one thats broken in a
>>>>>>>> different way that I can probably cobble together with the remains =
of
>>>>>>>> mine if its something more critical that has died.
>>>>>>>
>>>>>>> Good to hear, let's hope it just needs a new battery.
>>>>>>>
>>>>>>> See also the n8x0 thread. If we get drivers/cbus to mainline, we
>>>>>>> pretty much have everything we need for 770 in mainline too.
>>>>>>>
>>>>>>> It would be nice to get the drivers/mmc/host/omap.c patch integrated
>>>>>>> for 2.6.30 to make omap1 MMC work again. Ladislav, any news on that?
>>>>>>
>>>>>> OK! My friend has lent me his N770 in the meantime so I can get
>>>>>> going again. It seems the board is fried on mine as my battery
>>>>>> works perfectly fine in his. gah!
>>>>>>
>>>>>> Anyway, I have just tried disabling RESET_CLOCKS, but it still
>>>>>> doesn't work for me with the very latest linux-omap-2.6.
>>>>>>
>>>>>> With my HWA patch applied, at least the screen goes black, but I
>>>>>> don't see any console output, and the thing doesn't appear as a
>>>>>> USB gadget (I'm mounting NFS as root over USB with cdc_ether).
>>>>>>
>>>>>> I wish the thing had an LED I could turn on! Hmm, I wonder if I
>>>>>> could turn off the backlight easily..
>>>>>
>>>>> Actually, after playing a bit, I discovered I'm getting a boot
>>>>> penguin logo ok, but no actual textual console output; weird!
>>>>
>>>> I feel really silly; the N770's bootloader had "serial-console"
>>>> enabled, which meant all the kernel messages were being sent out that
>>>> instead of being displayed on the fb. So I can now see WTF is going on!
>>>>
>>>> Next problem for me: ohci-hcd.c is reporting an initialisation error
>>>> in the latest kernels, which is why my NFS-over-USB mount fails. I
>>>> can't see any changes in the initialisation *values* used, but there
>>>> have obviously been the "kill OMAP_TAG_USB" changes; I'm wondering if
>>>> its some initialisation ordering problem.
>>>
>>> OK got it, it IS a timing problem, due to non-ARM changes in the core
>>> kernel (possibly the recent async subsystem startup improvements?).
>>>
>>> In the middle of the boot with a recent kernel, I see a message
>>> "tahvo-usb: no tahvo_otg_dev" coming from
>>> drivers/cbus/tahvo-usb.c/omap_otg_init(). This is because the internal
>>> field "tahvo_otg_dev" is NULL. In turn, omap_otg_init() is being called
>>> by tahvo_usb_become_peripheral() which is called from higher up in the
>>> USB stack.
>>>
>>> However, from the code, what is /meant/ to happen is that the "omap_otg"
>>> driver is meant to call omap_otg_probe() (which sets that field) before
>>> anything calls drivers/cbus/tahvo-usb.c/omap_otg_init(). However, due to
>>> the timing problem, it occurs out of sequence, so it thinks there isn't =
a
>>> transceiver present.
>>>
>>> tahvo-usb.c looks as though it needs sorting out somehow; it seems to
>>> consist of two seperate drivers rammed together, plus it has this timing
>>> issue. The tahvo-usb code itself suggests splitting the tahvo-usb driver
>>> into an "omap-otg.c" driver, though some thought will be needed to
>>> eliminate the timing issue properly.
>>>
>>
>> Hmm, a quick diff with $ git diff omap-2.6.28..master drivers/Makefile
>> shows that cbus order has changed in the Makefile, maybe that causes it?
>
> Oooh that'd be horrible! but reverting it doesn't appear fix anything.
>
> Anyway, the breaking changeset doesn't have that change in it... its =20
> still the ones that I highlighted at the start of this thread.
>
> Doing
>
> git log -p =20
> eba05254cb561dc27d5664503f91f7c21954e648..0595ee8a05836666b225e6bf003ede0d=
a1e6e329 =20
> drivers/Makefile
>
> Doesn't show any ordering changes in Makefile affecting cbus or platform..=
.
>
> Incidentally, I tried turning on CONFIG_BOOT_PRINTK_DELAY with a =20
> boot_delay=3D100. With that, it now DOES probe the omap_otg device in =20
> tahvo-usb first, but it dies with a NULL pointer dereference. Still =20
> sounds like an initialisation timing problem here...

The attached (nasty!) debugging patch reveals that omap_otg_probe() is =20
not actually being called at all! Only tahvo_usb_become_peripheral() =20
is called.

If I comment out the:

#ifdef CONFIG_USB_OTG
         if (!tahvo_otg_dev) {
                 printk("tahvo-usb: no tahvo_otg_dev\n");
                 return -ENODEV;
         }
#endif

section, then it sees my USB device and attempts to boot over NFS. Of =20
course, this isn't a proper solution :)

--=_1scpxcsblm5c
Content-Type: text/x-patch;
	charset=UTF-8;
	name="tahvo-debug.patch"
Content-Disposition: attachment;
	filename="tahvo-debug.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index d8ad836..2835075 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -150,6 +150,8 @@ static int omap_otg_init(void)
 {
 =09u32 l;
=20
+=09printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D INIT\n");
+
 #ifdef CONFIG_USB_OTG
 =09if (!tahvo_otg_dev) {
 =09=09printk("tahvo-usb: no tahvo_otg_dev\n");
@@ -190,6 +192,8 @@ static int omap_otg_probe(struct device *dev)
 {
 =09int ret;
=20
+=09printk("+++++++++++++++++++++++++++++++++++++++++ PROBE\n");
+
 =09tahvo_otg_dev =3D to_platform_device(dev);
 =09ret =3D omap_otg_init();
 =09if (ret !=3D 0) {
@@ -334,6 +338,9 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
 {
 =09u32 l;
=20
+=09printk("+++++++++++++++++++++++++++++++++++++++++ HOST\n");
+
+
 =09/* Clear system and transceiver controlled bits
 =09 * also mark the A-session is always valid */
 =09omap_otg_init();
@@ -361,6 +368,9 @@ static void tahvo_usb_become_peripheral(struct tahvo_usb=
 *tu)
 {
 =09u32 l;
=20
+=09printk("+++++++++++++++++++++++++++++++++++++++++ PERIPHERAL\n");
+
+
 =09/* Clear system and transceiver controlled bits
 =09 * and enable ID to mark peripheral mode and
 =09 * BSESSEND to mark no Vbus */
--=_1scpxcsblm5c--

