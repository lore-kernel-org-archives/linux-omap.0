From: "Boivin, Robin" <RBoivin@oerlikon.ca>
Subject: RE: Reading gpio
Date: Wed, 17 Jan 2007 09:00:46 -0500
Message-ID: <B50FF75CBCFA2E4E8D23F26E18F52B10E7B2D9@mail.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Class: urn:content-classes:message
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

Hi,

I had the same requirements but did'nt want to play in the Kernel space =
to handle a single GPIO. The only solution I found is to use a program =
that read/writes in the registers of the OMAP without having to write a =
driver. So directly from the user space you can use the devmem2 =
function. It is a simple program to read/write from/to any location in =
memory. But be careful with that, you could get in trouble since other =
threads from the Kernel could have concurrent accesses to your =
ressources.

Just GOOGLE devmem2 and you'll find it.

Robin

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com]On Behalf Of
Arnold
Sent: January 17, 2007 4:52 AM
To: linux-omap-open-source@linux.omap.com
Subject: Reading gpio


Hi,

Is there anyone who knows how to read the gpio at the
same time without using the omap_get_gpio_datain
function? Using the omap_get_gpio_datain is taking so
long especially when you read 4 gpio and it should be
read with a time constraint. Is there anyone who can
help? I am using an omap5912. Thank you very much.

Thanks,
=20


=20
_________________________________________________________________________=
___________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
