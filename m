From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: DSPBRIDGE: segmentation fault after reloading dspbridge several
 times due to a memory leak.
Date: Wed, 11 Mar 2009 19:03:40 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33675 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZCLADr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 20:03:47 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C03fNM012919
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 19:03:46 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C03epG024803
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 19:03:40 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi All,
=A0
=A0=A0=A0=A0=A0=A0=A0 Reloading the dspbridge several times I am gettin=
g a Segmentation fault. Seeing the log it seems that the memory was exh=
austed=20
=A0
The error happens when ioremap is called

void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
{
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 poolVirtBase;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* get the virtual address for the ph=
ysical memory pool passed */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 poolVirtBase =3D (u32)ioremap(poolPhy=
sBase, poolSize);
=2E

Putting some printk's and printing the address returned by ioremap, I r=
ealized that address returned by ioremap each time I reload the dspbrid=
ge is different, in fact the address is increasing. I also put a printk=
 where iounmap is called to make sure it is called and yes it is actual=
ly called. However testing with a kernel + bridge for linux 23x I alway=
s get the same address for pool memory. Any idea what the problem is? I=
 have included the console output where you can see the address increas=
ing.

Regards,
=46ernando.


=A0
The first 15 loads and unloads=20
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D c8000000
Releasing External memory pool, address =3D c8000000
interation 2
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D c9000000
Releasing External memory pool, address =3D c9000000
interation 3
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D c9800000
Releasing External memory pool, address =3D c9800000
interation 4
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D ca800000
Releasing External memory pool, address =3D ca800000
interation 5
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D cb000000
Releasing External memory pool, address =3D cb000000
interation 6
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D cc000000
Releasing External memory pool, address =3D cc000000
interation 7
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D cc800000
Releasing External memory pool, address =3D cc800000
interation 8
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D c8800000
Releasing External memory pool, address =3D c8800000
interation 9
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D ca000000
Releasing External memory pool, address =3D ca000000
interation 10
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D cd000000
Releasing External memory pool, address =3D cd000000
interation 11
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D cd800000
Releasing External memory pool, address =3D cd800000
interation 12
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D ce800000
Releasing External memory pool, address =3D ce800000
interation 13
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D cf000000
Releasing External memory pool, address =3D cf000000
interation 14
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D d0000000
Releasing External memory pool, address =3D d0000000
interation 15
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D d0800000
Releasing External memory pool, address =3D d0800000
=2E..
=A0
and It crashes in the 33rd reload.
=A0
=A0
interation 32
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
[PHYS_POOL]Mapping External, address =3D d7800000
Releasing External memory pool, address =3D d7800000
interation 33
INFO: For help run script as ./install_bridge help
INFO:Installed Bridgedriver from current directory:/dspbridge_os
<4>vmap allocation failed: use vmalloc=3D<size> to increase size.
vmap allocation failed: use vmalloc=3D<size> to increase size.
[PHYS_POOL]Mapping External, address =3D 0
<4>coherent allocation too big (requested 0x400000 mask 0xffffffff)
coherent allocation too big (requested 0x400000 mask 0xffffffff)
drivers/dsp/bridge/rmgr/drv.c, line 1546: Assertion ((DSP_SUCCEEDED(sta=
tus) && p
DevNodeString !=3D NULL && !LST_IsEmpty(pDRVObject->devNodeString)) || =
(DSP_FAILED
(status) && *pDevNodeString =3D=3D 0)) failed.
drivers/dsp/bridge/rmgr/drv.c, line 1546: Assertion ((DSP_SUCCEEDED(sta=
tus) && p
DevNodeString !=3D NULL && !LST_IsEmpty(pDRVObject->devNodeString)) || =
(DSP_FAILED
(status) && *pDevNodeString =3D=3D 0)) failed.
drivers/dsp/bridge/rmgr/drv_interface.c, line 484: Assertion (status =3D=
=3D 0) faile
d.
drivers/dsp/bridge/rmgr/drv_interface.c, line 484: Assertion (status =3D=
=3D 0) faile
d.
drivers/dsp/bridge/rmgr/drv_interface.c, line 485: Assertion (DSP_SUCCE=
EDED(init
Status)) failed.
drivers/dsp/bridge/rmgr/drv_interface.c, line 485: Assertion (DSP_SUCCE=
EDED(init
Status)) failed.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
