From: "Carl Benson" <Carl.Benson@combra.se>
Subject: RE: ALSA driver for audio codec on TWL4030
Date: Tue, 18 Dec 2007 14:54:15 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88E0E@zeus.Combra.se>
References: <376191c90712131052p359b9927ic31671ed8b4de0f8@mail.gmail.com>
	<7EAD1AEEA7621C45899FE99123E124A001453D3B@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi. I downloaded the newly available 2.6.22.1 kernel for OMAP3430 and =
testet on an 3430SDP ES1.0 board. No problem booting, however when I try =
to play audio, it sounds corrupted and as if only every half sample is =
played (without increased pitch, the whole audio sample is played back =
really fast and finished in half its real playing time). I am using =
madplay as an MP3 decoder together with OSS emulation. Anyone else who =
experienced any problems? Any suggestion on how I might debug it?
=20
thanks,
/carl

________________________________

From: =
linux-omap-open-source-bounces+carl.benson=3Dcombra.se@linux.omap.com on =
behalf of Syed Mohammed, Khasim
Sent: Fri 12/14/2007 2:04 PM
To: Shobhit Kumar; linux-omap-open-source@linux.omap.com
Subject: RE: ALSA driver for audio codec on TWL4030





> -----Original Message-----
> From: linux-omap-open-source-bounces+khasim=3Dti.com@linux.omap.com
> [mailto:linux-omap-open-source-bounces+khasim=3Dti.com@linux.omap.com] =
On
> Behalf Of Shobhit Kumar
> Sent: Friday, December 14, 2007 12:22 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: ALSA driver for audio codec on TWL4030
>
> Hi,I was planning to use the 2.6.21 kernel from the omap git tree, but
> found
> that the ALSA driver for audio codec on TWL4030 is not included. I =
checked
> the 2.6.14 release from TI which has the driver for the same. But this
> same
> driver cannot probably used as is on 2.6.21 kernel due to various ALSA
> framework changes.
>
> Is there a port available on 2.6.21 kernel or would I have to port =
it..
>

We have uploaded new source for 3430 on linux.omap.com, it is 2.6.22 =
based. This should also be working for 2430. I think you can use the =
ALSA framework here for 2430 or switch your complete work to 2.6.22.

Regards,
Khasim
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
