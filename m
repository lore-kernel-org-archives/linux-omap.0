From: "Birger Kroon" <Birger.Kroon@sys.teleca.se>
Subject: OMAP 5912OSK and touchscreen under Qt/Embedded
Date: Tue, 13 Jun 2006 16:05:16 +0200
Message-ID: <CA21EAA4DF189C40A3BC30A5A75DA56001D4C846@ratatosk>
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

Hi list
=20
Does anyone here have experience of getting a touchscreen working with =
Qt/embedded?
=20
* I'm currently using the OMAP 5912OSK with the Mistral LCD unit.
* I've got Qt/Embedded up and running on the platform (at least the =
display).=20
* I'm using the latest kernel/patch.
* I see events when I touch the screen so the low level drivers does =
work correct I beleive.
=20
My problem is that I do not know how to connect Qt/E with the touch =
screen drivers in the correct way. I've testet to set the =
'QWS_MOUSE_PROTO' environment variable to different thing, but w/o =
success.=20

- Do I need the tslib to use a TS under Qt/E?=20
- Do I have to subclass QWSMouseHandler?

Any input would be much appriciated.

Regards
// Birger=20
=20
=20
Birger Kroon=20
Software Engineer=20
Automotive Solutions

Teleca Sweden West AB=20
Lindholmspiren 9=20
SE-417 56 G=F6teborg=20
Sweden=20
Tel +46 31 744 80 00=20
Fax +46 31 744 80 01=20

Direct +46 31 744 80 87=20
Mobile +46 703 79 19 11=20
birger.kroon@sys.teleca.se=20
www.teleca.com
