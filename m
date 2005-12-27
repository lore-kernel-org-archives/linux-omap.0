From: Ola Helm <ola.hel@gmail.com>
Subject: Re: Problem with flashing and/or starting UBoot with 2420
Date: Tue, 27 Dec 2005 10:21:58 +0200
Message-ID: <3d3153f60512270021p638ce630w28819f7f910eef04@mail.gmail.com>
References: <3d3153f60512230139v57b3a30dh2346e44ad2b17da8@mail.gmail.com>
	<20051223112235.86861.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051223112235.86861.qmail@web32905.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks for quick answering, unfortunately I haven't been able to mess aroun=
d
with board.

Yes, seems to be that boot is for NAND and not NOR. Thus it is actually
opposite you said i.e.  I'm trying to flash & boot from NOR but the UBoot i=
s
for NAND.

As it comes to link you send, it does not work for me. The switch positions
are besides for serial flashing also for some other board since OSTTool onl=
y
waits for USB device connection. There is probably ome way to do the NAND
flashing with this board too, but I haven't yet figured what it is. NOR USB
flashing switch postions are as I wrote with this board.

But I'll check out the compling with NOR setiings next.

/O

On 12/23/05, Komal Shah <komal_shah802003@yahoo.com > wrote:
>
> --- Ola Helm <ola.hel@gmail.com > wrote:
>
> From this I can make out that, you are trying to boot from NAND instead
> of NOR ...!!! Switch positions on processor daughter card is wrong.
>
> Does u-boot compiled for NAND or NOR? Please undefine
> #CONFIG_NAND_BOOT.
>
> Please see this:
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/0059=
94.html
>
>
> ---Komal Shah
> http://komalshah.blogspot.com/
>
>
>
>
> __________________________________
> Yahoo! for Good - Make a difference this year.
> http://brand.yahoo.com/cybergivingweek2005/
>
