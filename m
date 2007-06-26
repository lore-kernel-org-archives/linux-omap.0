From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: U-Boot modifications
Date: Tue, 26 Jun 2007 12:36:46 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C601D1B85E@dlee12.ent.ti.com>
References: <ae36f8040706261023w1b65ea99t52f46d9151dfeb68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <ae36f8040706261023w1b65ea99t52f46d9151dfeb68@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

I did this at one time, but my code is at home.  It is fairly easy to =
do.  From what I remember, there is usbtty code for the SX1 (or might be =
sx1) board.  It was an OMAP1510 and used a usb console.  First I =
modified the include/configs/omap5912osk.h file to support usbtty.  Look =
at the include/configs/sx1.h file to see what to add.  Then I went into =
drivers/ and modified the usb relevant files that had #ifdef OMAP1510 to =
have #if (defined(OMAP1510) || defined(OMAP1610)).  There was something =
else I had to change that was sx1 specific.  All I remember is that I =
commented it out.

I connected the OSK to a PC running Linux.  After booting the OSK, I =
looked to see if I had a VID/PID for a new USB device on my PC.

I hope this helps.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of =
Lu=EDs Vit=F3rio Cargnini
Sent: Tuesday, June 26, 2007 12:24 PM
To: OMAP
Subject: U-Boot modifications

Dear colleagues:
I need to modify uBoot for my osk 5912, I want to change the console to =
USB,
where could i find information on how to do this modification on my =
uBoot

--=20
-------------------------------------------------------------------------=
-----
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 - Building 30
P.O. Box: 90619-900 - Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
-------------------------------------------------------------------------=
--------
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
