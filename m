From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP: MUSB: MUSB fix to work as Module for 24xx/Davinci
Date: Fri, 30 Nov 2007 10:51:33 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003F30BB4@dbde01.ent.ti.com>
References: <5DF83221BE20114E9C331F665ACBC08003E7FAE3@dbde01.ent.ti.com>
	<200711291022.23735.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200711291022.23735.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi David

>I don't understand the point of this patch.  It certainly used to
>work as a module on DaVinci ... as recently as a few months ago.

For 24xx, MUSB as module was not working since one year I started =
looking into it.
Since CONFIGDATA register needs the index register to be zero. This is =
not mentioned in the register description but in the Table in the =
beginning of the Mentor Spec PG.

"Reference Mentor Spec 2 . 1 . MUSBMHDRC REGISTER MAP
ConfigData Returns details of core configuration. (Index register set to =
select Endpoint 0.) 2.3.4"

So on a reload of module, the index register is some value and the =
CONFIGDATA value is not got correctly and module load fails.

After this fix, the module loading/un-loading works.

>
>And this particular register is at a fixed location, not subject
>to the usual register banking stuff.  Kicking in that banking
>logic would be incorrect.

"Reference Mentor Spec 2 . 1 . MUSBMHDRC REGISTER MAP
ConfigData Returns details of core configuration. (Index register set to =
select Endpoint 0.) 2.3.4"

>
>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>
>> Index: linux-omap/drivers/usb/musb/musb_core.c
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap.orig/drivers/usb/musb/musb_core.c	2007-11-20 =
14:24:03.000000000 +0530
>> +++ linux-omap/drivers/usb/musb/musb_core.c	2007-11-20 =
14:26:22.000000000 +0530
>> @@ -1336,7 +1336,7 @@
>>
>>  	/* log core options (read using indexed model) */
>>  	musb_ep_select(mbase, 0);
>> -	reg =3D musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
>> +	reg =3D musb_readb(mbase, MUSB_EP_OFFSET(0, MUSB_CONFIGDATA));
>>
>>  	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : =
"UTMI-8");
>>  	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
