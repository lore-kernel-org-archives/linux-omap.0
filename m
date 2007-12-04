From: "Grubner, Martin" <mgrubner@doble.com>
Subject: RE: MEASURING CURRENT DRAWN BY OMAP5912
Date: Tue, 4 Dec 2007 08:58:24 -0500
Message-ID: <6ED95C184239FC419DFE88BA479737655DF863DF@mailnt.doble.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
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
To: ext-felipe.lima@nokia.com, "ext Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Felipe,
The spectrum digital eval board OSK5912 has 1 ohm resistors on each of =
the OMAP power rails. This allows for taking current measurement data =
for each rail. The user's manual on their website has some more info on =
current and how to calculate it. Look at
http://omap.spectrumdigital.com/osk5912/


-----Original Message-----
From:	linux-omap-open-source-bounces@linux.omap.com on behalf of Felipe =
Balbi
Sent:	Tue 12/4/2007 7:19 AM
To:	ext Azhar Mr.
Cc:	linux-omap-open-source@linux.omap.com
Subject:	Re: MEASURING CURRENT DRAWN BY OMAP5912

On Tue, Dec 04, 2007 at 07:44:29AM +0000, ext Azhar Mr. wrote:
> Hello Everyone,
>   =20
>           I want to measure the amount of current drawn by the OMAP =
5912 board.
>   Please somebody help me in providing the procedure to measure the =
current.
>   =20
>          I also want to measure the current when external devices like =
COMPACT FLASH, USB, WEBCAM, KEYPAD, GPS are connected to the OMAP5912.

Powering it up with an external controllable power supply is the best
choice.

I mean those where you can set the voltage to source. Use on of those
and you can read the current being drawn.


--=20
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

INdT - OSMRC - Manaus
Core Team
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
