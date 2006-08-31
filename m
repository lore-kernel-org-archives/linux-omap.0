From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: How to upload u-boot to H3 with serial port ?
Date: Thu, 31 Aug 2006 06:46:10 -0500
Message-ID: <A794DE2F81AEF94099397C9D7D5B651E5FB107@dlee08.ent.ti.com>
References: <5a2ffe1f0608310014s40fb58fbh8e5993872b6c3eb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <5a2ffe1f0608310014s40fb58fbh8e5993872b6c3eb8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Amit Verma <vermanamit@gmail.com>, Ningzhong Miao - ??? <Ningzhong.Miao@palmsource.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Actually, newer versions CCS can work with ELF format.  I know 3.1 and
higher support ELF and I think 2.4 does.  ELF is the format of the
u-boot executable so you would download and run that file.

Typically, I use CCS or Trace32 to download u-boot, run it, then use it
to download u-boot.bin and flash that.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Amit
Verma
Sent: Thursday, August 31, 2006 2:15 AM
To: Ningzhong Miao - ???
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: How to upload u-boot to H3 with serial port ?

Hi Miao

U would need to have ( correctly [ARM] compiled ) u-boot image that
you can flash thru flashing tool (CCS is a good option) using JTAG
(thru USB) onto the target (H3). You can flash it to say NOR flash
memory of the target. Plz note CCS expects the image to be in " .out "
format & image is meant for exact/proper address of the memory on
which it is to be flashed.

Once you have flashed, you can boot the target and you should have
some Hyperterminal (Tera Term is a good option) on which you can get
the u-boot prompt (on the RS232 console).

Thanks
-Amit Verma @ vermanamit@gmail.com


On 8/31/06, Ningzhong Miao - ??? <Ningzhong.Miao@palmsource.com> wrote:
> I am lucky to get a H3 board.
>
> I connect the serial port of H3 to my PC, and then power up H3, the
> serial port don't give any data and minicom don't have any print. So I
> think the H3 board don't have a bootloader yet.
>
>
>
> I want upload u-boot to H3, but I don't have JTAG and CCS, I only have
> serial port.
>
> How should I upload u-boot to H3 with serial port ?
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
