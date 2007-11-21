From: "Carl Benson" <Carl.Benson@combra.se>
Subject: RE: Unhandled fault: external abort
Date: Wed, 21 Nov 2007 08:25:39 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88DFB@zeus.Combra.se>
References: <D0D7E940253EF8428A27241F8E3CABA3A88DFA@zeus.Combra.se><1195575797.6227.4.camel@vence.hilman.org>
	<1195587066.17706.8.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Thanks, I got it running by disabling UART3. Looking forward to your =
solution.

regards,
Carl Benson


-----Original Message-----
From: Kevin Hilman [mailto:khilman@mvista.com]
Sent: Tue 11/20/2007 8:31 PM
To: Carl Benson
Cc: OMAP-Linux
Subject: Re: Unhandled fault: external abort
=20

On Tue, 2007-11-20 at 08:23 -0800, Kevin Hilman wrote:
> On Tue, 2007-11-20 at 16:37 +0100, Carl Benson wrote:
> > Hi. Trying to boot latest OMAP kernel from GIT tree (as of =
2007-11-20) on an 3430 SDP ES1.0 board and get an "Unhandled fault: =
external abort on non-linefetch" and "Internal error 1028".=20
> >=20
> > PC is at serial_in+0x6c/0xac which in my kernel suggest the error =
occuring from executing line 366 from drivers/serial/8250.c:
>=20
> I have this same problem.
>=20
> The problem is because the bootloader is not enabling all the clocks
> required for UART3 to work on OMAP3.
>=20
> To get yourself booting, you can just disable the 3rd UART until we =
fix
> this problem.  Try the patch below:

I just found the root cause of this.  Patch coming shortly.

Kevin
