From: "Ola Helm" <ola.hel@gmail.com>
Subject: Re: Trasnferring u-boot to P2 730
Date: Mon, 10 Apr 2006 11:54:34 +0300
Message-ID: <3d3153f60604100154w22e5a845p4411e3aa3c0d7757@mail.gmail.com>
References: <3d3153f60604070015g5e260b69v3bc680d29f99fc@mail.gmail.com>
	<44369A4B.4050801@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44369A4B.4050801@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
Cc: kangjw@lenovo.com, cp_singh@faith.co.jp
List-Id: linux-omap@vger.kernel.org

Thanks a lot for everybody for your help!

With these bits and pieces it seems to be that perhaps the most easiest way
to handle this would be to first add this small header, which should perhap=
s
be done with some tool tends to be called preimage_flash or something like
that. It cannot be done manually at least in my case when you really don't
know excatly what should be done. Then the image could be downloaded either
using some serial tool with some name (could it be OMAP730 Host Loader I sa=
w
in some in picture of some documetation) or using MMC.

So, does anybody have a glue either
- where to get the preflash_image tool
- how to excatly modify u-boot file manually
- where to get the serial loader tool for 730

As I said, I have not been able to twist the OST tool version I have
(version 2.5, available also from TI website) to work with 730, not even to
download it.

I was able to download the u-boot.bin (the raw binary) as well as u-boot
> (ELF image) to P2's RAM using OST Tools over a serial line (COM1). I has
> success in downloading u-boot to the specific address in RAM, but the ima=
ge
> doesn't seem to execute/run. ALso, there is a provision of downloading
> images over the USB connection to the target, but in my case my Windows P=
C
> does not detect the P2 board as a USB device when I connect the board to =
the
> host PC with a USB cable. Rather, the charging LED on the board blinks fo=
r a
> second.
>
>


> OST tools installer for OMAP 730 can be found at
> http://focus.ti.com/download/wtbu/OSTBoot_NoSource_1.6.1.zip, the
> installer accompanies a User guide as well in PDF format.
>


Chetan, which version have you used since you have been able to aat least
download the image to board? And furthermore, I do have the OST boot you
mentioned in your mail but as far as I know that package does not include
any executables and is anyway more 2420 oriented package. What kind of usag=
e
do you mean with it?


> I did this once via an Abatron BDI-2000.  George Davis had previously
> got it working using the small JTAG debug board that shipped with some
> versions of OMAP 730/16xx based on the "surfer" board; so far as I know
> we never got a BDI to talk to the multiport debug card shipped with P2
> boards.  On the JTAG board:
>
>

Todd, do you mean that there is some other debug device than that normally
coming with 730 boards?

BRs,

/O
