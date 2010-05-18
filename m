From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 16:31:45 +0300 (EEST)
Message-ID: <20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<20100518.114642.35020415.Hiroshi.DOYU@nokia.com>
	<AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_May_18_16_31_45_2010_105)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18676 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab0ERNcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 09:32:03 -0400
In-Reply-To: <AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk

----Next_Part(Tue_May_18_16_31_45_2010_105)--
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 14:03:26 +0200

> On Tue, May 18, 2010 at 11:46 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
>> Date: Fri, 14 May 2010 17:01:33 +0200
>>
>>> Hi,
>>>
>>> The main purpose of this patch series is to be able to compile mach=
 platform
>>> data as built-in. Otherwise, client modules such as bridgedriver wi=
ll load the
>>> platform code, but not the mach code when mailbox is built as a mod=
ule.
>>
>> I think that this is the *udev* responsibility. The udev should take=

>> care of loading mailbox_mach.ko since the mailbox platform device wa=
s
>> registered by devices.ko at bootup. devices.ko is built in earlier
>> than dspbridge.ko, so the mailbox platform device is registered
>> earlier than the dsp device, "C6410". this registration ordering
>> should take care of the dependency if the udevd works correctly.
> =

> I'm not familiar with this kind of module loading, but certainly not
> all systems have udev.
> =

> I realized the problem because I have a bare-bones system in my
> beagleboard where I had to manually load mailbox_mach.

With udev or something equivalent, it should work fine.

> =

>>> Unfortunately, there's no easy way to do that since plat and mach c=
ode are
>>> deepely interrelated. So the first patches try to separate the mail=
box
>>> registering through a defined omap_mbox_platform_data.
>>>
>>> Also, it's worth noting that mailboxes are not a one-to-one mapping=
 to
>>> resources; that is, some resources belong to multiple mboxes. So it=
's best to
>>> think of mailboxes as fake devices. That is why custom platform_dat=
a
>>> is required.
>>
>> Actually there were logical mailbox devices/instances implemented, b=
ut
>> it was broken partially when dropping mailbox class support by
>> accident(*1). This is the reason whey omap_mbox struct has unused de=
v
>> pointer now. At that time, the sysfs interface was not necessary but=

>> the device creation itself should not have been removed. I'll get th=
is
>> code back again soon.
>>
>> The role of each modules were/should be:
>>
>> =A0- devices.ko: =A0 =A0 =A0 =A0 a platform device, based on its res=
ource.
>> =A0- mailbox_mach.ko: =A0 =A0a platform driver to register multiple =
logical mboxes/devices.
>> =A0- mailbox.ko: =A0 =A0 =A0 =A0 a kind of framework which holds mul=
tiple logical mboxes/devices.
>>
>> The sysfs structure is like below:
>>
>> =A0~# tree -d -L 2 /sys/devices/platform/omap2-mailbox/
> =

> I don't see the point of having 'omap2' there, at best it should be
> 'omap-mailbox', or perhaps even just 'mailbox'.

Sounds nice.

>> The platform device omap2-mailbox accomodatess logical mboxes.
> =

> Wouldn't it be better the way my patches handle them?
>  * devices.ko:  doesn't care about mbox
>  * mach_omap1/mailbox.ko:  registers "omap-mailbox" platform device
> with a list of logical mboxes for OMAP1
>  * mach_omap2/mailbox.ko:  registers "omap-mailbox" platform device
> with a list of logical mboxes for OMAP2
>  * plat-omap/mailbox.ko: creates platform driver based on logical lis=
t
> of mboxes from platform device and handles the list internally
> =

> The end result would be the exactly same, except that there's no hard=

> dependency between the mach, and plat code.

With the attachemnt, which is just 17 lines of code, you will get the
structure of logical mbox devices, which are located under the single
platform device, "omap2-mailbox". This is more _descriptive_ since
it displays the connection of a platform device and logical devices,
IOW, where these logical ones come. I don't see any point of not using
this struture.

> =

>>> Finally, a bunch of cleaning up is done in the very first patches, =
specially for
>>> OMAP1.
>>
>> Most of the cleanups are quite ok.
>>
>> Would it be possible to rebase them on the top of my coming patch to=

>> get back logical device entry?
> =

> Where is that?

Attached. Would it be possible to rebase the cleanups on this one?

> =

>> Sorry for the late reply, it took some time to recall my bad memory.=
..
> =

> No worries.
> =

> Cheers.
> =

> -- =

> Felipe Contreras

----Next_Part(Tue_May_18_16_31_45_2010_105)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-omap-mailbox-Set-a-device-in-logical-mbox-instances-.patch"

>From c7e5d7342c3d0b975601ae4a6b8bdbe77b4d6a5d Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Tue, 18 May 2010 15:45:23 +0300
Subject: [PATCH 1/1] omap mailbox: Set a device in logical mbox instances for traceability

With this patch, you'll get the following sysfs directories. This
structure implies that a single platform device, "omap2-mailbox" holds
multiple logical mbox instances. This could be the base to add sysfs
files for each logical mboxes. Then userland application can access a
mbox through sysfs entries if necessary(ex: setting kfifo size
dynamically)

  ~# tree -d -L 2 /sys/devices/platform/omap2-mailbox/
  /sys/devices/platform/omap2-mailbox/
  |-- driver -> ../../../bus/platform/drivers/omap2-mailbox
  |-- mbox
  |   |-- dsp      <- they are each instances of logical mailbox.
  |   |-- ducati
  |   |-- iva2
  |   |-- mbox01
  |   |-- mbox02
  |   |-- mbox03
  |   |-- .....
  |   `-- tesla
  |-- power
  `-- subsystem -> ../../../bus/platform

This was wrongly dropped by:
     commit c7c158e57bce6220644f2bcd65d82e1468aa40ec

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index c549af3..36b3aa2 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -347,6 +347,8 @@ void omap_mbox_put(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_put);
 
+static struct class omap_mbox_class = { .name = "mbox", };
+
 int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 {
 	int ret = 0;
@@ -357,6 +359,11 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	if (mbox->next)
 		return -EBUSY;
 
+ 	mbox->dev = device_create(&omap_mbox_class,
+ 				  parent, 0, mbox, "%s", mbox->name);
+ 	if (IS_ERR(mbox->dev))
+ 		return PTR_ERR(mbox->dev);
+
 	spin_lock(&mboxes_lock);
 	tmp = find_mboxes(mbox->name);
 	if (*tmp) {
@@ -385,6 +392,7 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 			*tmp = mbox->next;
 			mbox->next = NULL;
 			spin_unlock(&mboxes_lock);
+			device_unregister(mbox->dev);
 			return 0;
 		}
 		tmp = &(*tmp)->next;
@@ -397,6 +405,12 @@ EXPORT_SYMBOL(omap_mbox_unregister);
 
 static int __init omap_mbox_init(void)
 {
+ 	int err;
+
+	err = class_register(&omap_mbox_class);
+	if (err)
+		return err;
+
 	mboxd = create_workqueue("mboxd");
 	if (!mboxd)
 		return -ENOMEM;
@@ -407,11 +421,12 @@ static int __init omap_mbox_init(void)
 
 	return 0;
 }
-module_init(omap_mbox_init);
+subsys_initcall(omap_mbox_init);
 
 static void __exit omap_mbox_exit(void)
 {
 	destroy_workqueue(mboxd);
+ 	class_unregister(&omap_mbox_class);
 }
 module_exit(omap_mbox_exit);
 
-- 
1.7.1.rc1


----Next_Part(Tue_May_18_16_31_45_2010_105)----
