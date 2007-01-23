From: "Leo Qin" <Leo.Qin@BENQ.COM>
Subject: RE: Linux-omap-open-source Digest, Vol 33, Issue 38
Date: Tue, 23 Jan 2007 13:57:40 +0800
Message-ID: <A00C960254B03941A1EBFB1155D12E81047C342A@BQC-MSV10.BQC.CORP.COM>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

=20
Hi,
has Linux been ported on OMAP1030V (Neptune ) ?
Anyone has tried it ?
Thanks a lot!


-----Original Message-----
From: linux-omap-open-source-bounces+leo.qin=3Dbenq.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+leo.qin=3Dbenq.com@linux.omap.com]=

On Behalf Of linux-omap-open-source-request@linux.omap.com
Sent: Tuesday, January 23, 2007 2:00 AM
To: linux-omap-open-source@linux.omap.com
Subject: Linux-omap-open-source Digest, Vol 33, Issue 38

Send Linux-omap-open-source mailing list submissions to
	linux-omap-open-source@linux.omap.com

To subscribe or unsubscribe via the World Wide Web, visit
	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
or, via email, send a message with subject or body 'help' to
	linux-omap-open-source-request@linux.omap.com

You can reach the person managing the list at
	linux-omap-open-source-owner@linux.omap.com

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linux-omap-open-source digest..."


Today's Topics:

   1. RE: u-boot delay on OMAP2430 SDP (Woodruff, Richard)
   2. Qtopia in OMAP (George Gu)
   3. SR0000007833891-Can't email to certain domains
      @linux.omap.com,	lists.debian.org and lists.sourceforge.net
      (HP-Messaging.L2@nokia.com)
   4. Re: u-boot delay on OMAP2430 SDP (sandeep prabhu)
   5. Basic N800 support (Kyungmin Park)
   6. Accessing DSP MMU on OMAP SDP2430 (rajeev  s)
   7. RE: Accessing DSP MMU on OMAP SDP2430 (Woodruff, Richard)
   8. Re: Basic N800 support (Tony Lindgren)


----------------------------------------------------------------------

Message: 1
Date: Sun, 21 Jan 2007 13:52:24 -0600
From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: u-boot delay on OMAP2430 SDP
To: "sandeep prabhu" <sandeep.mitian@gmail.com>,
	<Linux-omap-open-source@linux.omap.com>,
	<u-boot-users@lists.sourceforge.net>
Message-ID:
	<EA12F909C0431D458B9D18A176BEE4A5096FA751@dlee02.ent.ti.com>
Content-Type: text/plain;	charset=3D"us-ascii"

> I am using the "u-boot_16.3.tar.gz" ( u-boot version 1.1.4 ) sources=20
> downloaded from the "linux.omap.com" site, for booting the OMAP2430
SDP
> board
> from NOR flash. I built the sources for booting from NOR flash and
burn it
> using the CSST tool onto the OMAP2430 SDP board. It takes around 2 to
4
> minutes for u-boot command prompt. I am also not able to boot the
linux
> kernel with this version.

Well that shouldn't happen.  I've not seen that before.  However, I'm
not sure which snapshot is on the web.  A couple things come to mind as
possibilities.

-1- You need to set dip switches correctly.

-2- Some code was added for another program which created a path where
udelay was called before the timer was setup properly.  If you are
unlucky this can lock you up.  If you remove its usage in sys_info.c in
the board identification path it may fix your issue.  This is fixed in
later images.

Next week perhaps I can send you a binary which is known to be good.

Regards,
Richard W.


------------------------------

Message: 2
Date: Mon, 22 Jan 2007 08:55:46 +0800
From: "George Gu" <guxy@dspchina.com>
Subject: Qtopia in OMAP
To: <linux-omap-open-source@linux.omap.com>
Message-ID: <200701220056.l0M0umtb000362@blanco.ext.ti.com>
Content-Type: text/plain;	charset=3D"us-ascii"

Dear All,

I have ported Qtopia phone into OMAP by using fb0, but now I have to add
video disply in it,  does anyone have some suggestion? e.g. how to use
video OSD layer fb3 in Qt, is there any demo code?

George Gu
(Xiangyu Gu)
Wintech Digital System Co.
Beijing, China
Ph: 8610-8278-2828 ext.168
Fax: 8610-8278-0028
http://www.wintechdigtal.com
----------------------------



------------------------------

Message: 3
Date: Mon, 22 Jan 2007 11:27:18 +0800
From: <HP-Messaging.L2@nokia.com>
Subject: SR0000007833891-Can't email to certain domains
	@linux.omap.com,	lists.debian.org and
lists.sourceforge.net
To: <linux-usb-devel@lists.sourceforge.net>,
	<debian-embedded@lists.debian.org>,
	<linux-omap-open-source@linux.omap.com>
Cc: jorge.siqueira@indt.org.br, HP-Messaging.L2@nokia.com
Message-ID:
	<6065259110819A48A3DC58D4547FD46E08035E@siebe101.NOE.Nokia.com>
Content-Type: text/plain;	charset=3D"us-ascii"

Hi=20

This is the test mail=20

We have one customer reported they was unable to send mail to below
domain

Please reply to all if you able to received and cc a copy to
jorge.siqueira@indt.org.br=20

Thank you very much.=20

Best Regards,=20

=20

Chu Kim Huey=20

HP Operation Center=20

Nokia Business Infrastructure=20

Email : hp-messaging.l2@nokia.com =20

=20

Should you have any queries with regards to this ticket, Please liaise
with your Local Service Desk .=20

=20

Service Desk contact details can be found at
http://www.connecting.nokia.com/servicedesk/contact



------------------------------

Message: 4
Date: Mon, 22 Jan 2007 09:38:30 +0530
From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: Re: u-boot delay on OMAP2430 SDP
To: Linux-omap-open-source@linux.omap.com,
	u-boot-users@lists.sourceforge.net
Message-ID:
	<c04186510701212008h44a4180cy3738ffea9dc508ff@mail.gmail.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Hi,

I have removed udelay() in file board/omap2430sdp/sys_info.c and
replaced it by sdelay() function which doesn't make use of timer. Now
with this, OMAP2430 SDP is booting fine,

Thanks Richard,
sandeep


On 1/21/07, sandeep prabhu <sandeep.mitian@gmail.com> wrote:
>
>
> Hi,
>
> I am using the "u-boot_16.3.tar.gz" ( u-boot version 1.1.4 ) sources=20
> downloaded from the " linux.omap.com" site, for booting the OMAP2430=20
> SDP board from NOR flash. I built the sources for booting from NOR=20
> flash and burn it using the CSST tool onto the OMAP2430 SDP board. It=20
> takes around 2 to 4 minutes for u-boot command prompt. I am also not=20
> able to boot the linux kernel with this version.
>
> I have tried to track exactly where is it getting delayed, as it hangs

> for
> 2-3 minutes in  function "dram_init"  in file=20
> "board/omap2430sdp/omap2430sdp.c". But it doesnt hang at the same code

> everytime I test, the problem is not consistent.
> I have tried with Icache both enabling and disabling, but it did not=20
> make any difference.
>
> Could anyone give some pointers about what could be the issue ?
>
> Thanks in advance,
>
> --
> Warm Regards,
> Sandeep




--
Warm Regards,
Sandeep


------------------------------

Message: 5
Date: Mon, 22 Jan 2007 07:55:04 +0000 (GMT)
From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Basic N800 support
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap-open-source@linux.omap.com"
	<linux-omap-open-source@linux.omap.com>
Message-ID: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
Content-Type: text/plain; charset=3Dwindows-1252

Hi Tony,

Thank you for releasing N800 source code.
It's very helpful for OMAP2 board, such as Apollon.

I checked and downloaded the source code in maemo.
I'll check the OMAP2 core stuff and OneNAND in apollon board.

Thank you,
Kyungmin Park

P.S., Is it possible to change 'omap2.c' in drivers/mtd/onenand to
'n800.c' or another? It's not generic for OMAP2. :)


------- Original Message -------
Sender : Tony Lindgren<tony@atomide.com>=20
Date   : Jan 20, 2007 05:57
Title  : [PATCH] Basic N800 support

Hi,

Here's a quick patch of N800 support against the current git tree for
people to play with until we get N800 support merged in. It just
contains the board support and basic NAND changes to get root mounted,
so most driver changes are not included.=20

Regards,

Tony


------------------------------

Message: 6
Date: 22 Jan 2007 09:55:04 -0000
From: "rajeev  s" <rajeev2174@rediffmail.com>
Subject: Accessing DSP MMU on OMAP SDP2430
To: "linux_omap_open_source" <linux-omap-open-source@linux.omap.com>
Message-ID: <20070122095504.11749.qmail@webmail25.rediffmail.com>
Content-Type: text/plain; charset=3D"ISO-8859-1"

Hi All,I have an sdp2430 board (OMAP2430 based).I want to access the DSP
MMU registers from the ARM side .The Address base of this DSP MMU
Register is on the Address range 0x5d000000. To access these registers
from ARM to setup the MMU Translation i added the following code in the
file:include/asm/arch-omap/io.h (Linux source is 2.6-19):#define
IO_VIRT_DSP_L2_RAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xED000000&nbsp; /* va
of&nbsp;DSP MMU&nbsp;*/I arrived at this address using the following
logic :0x5d000000&nbsp;+ 0x90000000 =3D 0xED000000.When i access the DSP
MMU address registers from the Virtual Address base 0xED000000&nbsp;, i
get an kernel crash.Also i have created an entry for this address in the
io.c file as well.Could anybody let me know am i following the correct
procedure.ThanksRajeev

raj

------------------------------

Message: 7
Date: Mon, 22 Jan 2007 07:23:47 -0600
From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Accessing DSP MMU on OMAP SDP2430
To: "rajeev  s" <rajeev2174@rediffmail.com>,	"linux_omap_open_source"
	<linux-omap-open-source@linux.omap.com>
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429287F8E@dlee13.ent.ti.com>
Content-Type: text/plain;	charset=3D"US-ASCII"

Depending on when you want to access it and how often you will either
chose to create a static map for the device or just ioremap it.

If you don't need to access it much and you don't need it a very early
states of the boot process it is probably just as well to dynamically do
handle it with ioremap.

If you are set on static mapping it you can google up an old mail on
this list where I give a lot of information on a thread about internal
sram.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of rajeev s
> Sent: Monday, January 22, 2007 3:55 AM
> To: linux_omap_open_source
> Subject: Accessing DSP MMU on OMAP SDP2430
>=20
> Hi All,I have an sdp2430 board (OMAP2430 based).I want to access the
DSP
> MMU registers from the ARM side .The Address base of this DSP MMU
Register
> is on the Address range 0x5d000000. To access these registers from ARM
to
> setup the MMU Translation i added the following code in the
> file:include/asm/arch-omap/io.h (Linux source is 2.6-19):#define
> IO_VIRT_DSP_L2_RAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xED000000&nbsp; /*
va
> of&nbsp;DSP MMU&nbsp;*/I arrived at this address using the following
logic
> :0x5d000000&nbsp;+ 0x90000000 =3D 0xED000000.When i access the DSP MMU
> address registers from the Virtual Address base 0xED000000&nbsp;, i
get an
> kernel crash.Also i have created an entry for this address in the io.c
> file as well.Could anybody let me know am i following the correct
> procedure.ThanksRajeev
>=20
> raj
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source


------------------------------

Message: 8
Date: Mon, 22 Jan 2007 09:12:55 -0800
From: Tony Lindgren <tony@atomide.com>
Subject: Re: Basic N800 support
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-omap-open-source@linux.omap.com"
	<linux-omap-open-source@linux.omap.com>
Message-ID: <20070122171254.GD7382@atomide.com>
Content-Type: text/plain; charset=3Dus-ascii

* Kyungmin Park <kyungmin.park@samsung.com> [070121 23:55]:
> Hi Tony,
>=20
> Thank you for releasing N800 source code.
> It's very helpful for OMAP2 board, such as Apollon.

Well I just took what Nokia published at maemo.org..
=20
> I checked and downloaded the source code in maemo.
> I'll check the OMAP2 core stuff and OneNAND in apollon board.
>=20
> Thank you,
> Kyungmin Park
>=20
> P.S., Is it possible to change 'omap2.c' in drivers/mtd/onenand to
'n800.c' or another? It's not generic for OMAP2. :)

Sure, maybe there's some code that should be shared though?

Regards,

Tony


------------------------------

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


End of Linux-omap-open-source Digest, Vol 33, Issue 38
******************************************************
