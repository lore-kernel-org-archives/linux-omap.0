From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: 12.x drivers need code cleanup.
Date: Thu, 10 May 2007 20:26:39 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47E2689E@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

All:

=20

I was reviewing following drivers from 12.x code base, they need some =
kind of code cleanup and Linux style indentation, commenting & coding =
standards to be applied.

=20

*	I2C controller driver
*	TWL code driver and header file
*	TWL GPIO driver and header file
*	TWL Keypad driver and corresponding header file
*	OMAP HS MMC driver=20
*	DMA library

=20

I will review more drivers by next week. Please consider this activity =
as a priority task, I would like to publish our 12.x code on =
linux.omap.com. It would be better if our code looks neat.

=20

I don't know if we have bandwidth for 18.x drivers, but its worth to go =
through our drivers and do some cleanups & adapt to Linux coding =
standards/guidelines.

=20

FYI: Last month our server "linux.omap.com" was blocked due to many =
downloads (for 2430 tarball) and we had to migrate to different server. =
This shows that community is interested to know and use our code. Our =
marketing/BE team directs customers to use our code from linux.omap.com. =
The code we put out there need not be in sync with community but it =
should adhere to Linux coding guidelines and standards. It's as =
important as getting any functionality working. In last month (if you =
have observed) I am going back and forth for keypad and TWL GPIO =
patches, majority of comments I am getting are for coding standards.

=20

Please consider your drivers as going to community and there is lot of =
audience to look at. We definitely put lot of effort in getting a =
functionality working but a bad looking code spoils all that effort.

=20

Suggestion:

I would like to suggest if Integration prime (Iqbal) can do a check for =
coding guidelines / standards before merging code into integration =
branch. We can run some scripts on code before checking the code into =
integration branch (generally public tree maintainers do this before =
taking the code into tree).

=20

Regards,

Khasim
