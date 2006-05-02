From: "Rick Foos" <rick@synchromeshcomputing.com>
Subject: Re: omap mmc build errors
Date: Tue, 2 May 2006 16:59:54 -0500
Message-ID: <00ae01c66e33$bf52cd20$7701a8c0@AthlonX2>
References: <443BAD8C.4090005@indt.org.br>	<20060413151756.47512.qmail@web32901.mail.mud.yahoo.com><20060502092025.GC24728@atomide.com>
	<4457CE22.8050702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

CONFIG_MMC_OMAP also allowed the git kernel to boot on OMAP 2420 H4, =
Thanks.
  ----- Original Message -----=20
  From: Kevin Hilman=20
  To: Tony Lindgren=20
  Cc: linux-omap-open-source@linux.omap.com=20
  Sent: Tuesday, May 02, 2006 4:24 PM
  Subject: Re: omap mmc build errors


  Tony Lindgren wrote:
  > * Komal Shah <komal_shah802003@yahoo.com> [060413 08:18]:
  >> --- Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
  >>
  >>> Hi Komal and folks,
  >>>
  >>> You have to apply a patch that Tony sent to the list 7 days ago. =
This
  >>>
  >>> patch corrects the bugs mentioned above. Attached to this mail =
follow
  >>>
  >> You still need the attached patch on top of the Tony's patch to =
build
  >> it successfully.
  >=20
  > I've just pushed that patch + fixed trying to ioremap a virtual =
address.
  > Seems to work now, can you test?

  Haven't had time to dig, but this builds but doesn't boot on 1710/H3.  =
Simply=20
  disabling CONFIG_MMC_OMAP makes it boot.

  Kevin
  _______________________________________________
  Linux-omap-open-source mailing list
  Linux-omap-open-source@linux.omap.com
  http://linux.omap.com/mailman/listinfo/linux-omap-open-source



  --=20
  No virus found in this incoming message.
  Checked by AVG Free Edition.
  Version: 7.1.385 / Virus Database: 268.5.1/328 - Release Date: =
5/1/2006
