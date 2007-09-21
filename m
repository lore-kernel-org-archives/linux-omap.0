From: <sshahrom@micron.com>
Subject: Data abort issue
Date: Fri, 21 Sep 2007 09:28:38 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6D4@ntxsjombx02.micron.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6D3@ntxsjombx02.micron.com>
	<a46a26fd0709201310ye0c3c96ib246dfdf114a02a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <a46a26fd0709201310ye0c3c96ib246dfdf114a02a9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: juha.kuikka@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Juha,
I have not seen that in linux kernel in version 2.6.21 or 2.6.23, I also =
use following gcc,
gcc version 3.4.0 20040409 (CodeSourcery ARM Q1A 2004)
gcc version 4.1.1 (CodeSourcery Sourcery G++ 2006q3-27)

Bootloader would cause data abort, and work around for that is:
	isEccFF  =3D ((*(u8 *)ecc_data1   & 0x00) =3D=3D 0x00);
	isEccFF |=3D ((*(u8 *)ecc_data1++ & 0xFF) =3D=3D 0xFF);
	isEccFF |=3D ((*(u8 *)ecc_data1++ & 0xFF) =3D=3D 0xFF);
	isEccFF |=3D ((*(u8 *)ecc_data1++ & 0xFF) =3D=3D 0xFF);
I hope that helped,
-Shahrom

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Juha =
Kuikka
Sent: Thursday, September 20, 2007 1:10 PM
To: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH 4/4] [MTD] NAND : Resubmitting support for 2K page =
nand

Hi Shahrom,

I ran into one problem with this code.

This line:
isEccFF =3D ((*(u32 *)ecc_data1 & 0xFFFFFF) =3D=3D 0xFFFFFF); in =
omap_compare_ecc will cause data abort on ARM as the pointer is not =
properly aligned for double word access.

 - Juha
