From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: Trasnferring u-boot to P2 730
Date: Fri, 7 Apr 2006 08:18:28 -0500
Message-ID: <99E943D7AA8E3A448619E1F809F2A2A202CE6ACF@dlee04.ent.ti.com>
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
To: Ola Helm <ola.hel@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I have not worked on P2 in a long time, but I recall that I used Code
Composer Studio with JTAG to download u-boot to the board.  CCS can load
ELF file formats, which is what u-boot is.  After downloading u-boot,
run it and then use it to flash u-boot.bin.  Remember that 'u-boot' is
the ELF executable that CCS can load while 'u-boot.bin' is the flat
binary file that you flash to the board.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Ola
Helm
Sent: Friday, April 07, 2006 2:16 AM
To: Linux-omap-open-source@linux.omap.com; Brian Swetland; Kevin Hilman;
cp_singh@faith.co.jp; kangjw@lenovo.com
Subject: Re:Trasnferring u-boot to P2 730

Hi,

I'm really in the need of answers for this case because I cannot get any
progress with this thing. So I'm daring to send this mail also to you
few
people who have been conversating here about 730 P2 during last month.
The
question is still: how have you managed to download u-boot to 730?

I hope I don't bother anybody too much when I'm sending the mail
directly
and apologies in case I do. In case you cannot answer to this e.g. due
to
customers etc. it is totally ok, just forget this.

Cheers,

/O



>
>
>
>
>
>
>
> Hi,
>
> I have searched the archives and and tried to find some discussion
about
> the
> issue and also checked out the /pub/documentation but none seems to
exist
> which would answer. I'm trying to find out how to transfer u-boot to
P2
> board. I'm interested to hear how have you managed to get the u-boot
-
> and
> furthermore anything - to board.
>
> My situation is that board have SysBoot 1.18 in it. It does recognize
and
> accept MMC and finds linking file, but it does not accept image
itself. It
>
> gives a message:"Valid image could not be found". I have tried
> self-compiled
> and downloaded u-boot.out, u-boot.bin and u-boot files with no result,
> can't
> get a reason for that..
>
> I'm also intrested is there a way to download the u-boot via serial
cable
> or
> other transfer method. I have tried to download with hyperterminal,
> minicom
> and OST Tool, but none seems to have any reaction to sysboot. I'm not
sure
> am I using correct addresses in OST tool for flashing/RAM download
thoug,
> I
> should use the debug board in some way I don't know, perhaps switches
are
> not in correct positions in either of boards (in target I (think) have
> tried
> them in almost all possible positions and in debug board I mainly
changed
> position of SW4-6 enabling/disabling RS-232 in either board and SW4-7
> changing UART 1 and 2) etc. etc.
>
> I have also tried to have connection via JTAG but it does not get
> connected
> even though I tried different switch / jumper settings, now
> JP1: 1-2
> JP2: 1-2
> JP3: 2-3
> (device does work, the reason is somewhere else).
>
> Ideas?
>
> /O
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>
>
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
