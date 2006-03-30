From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: OMAP development on a student budget
Date: Thu, 30 Mar 2006 03:47:06 -0600
Message-ID: <3D54759CE5A8F64BB2078090E91D50A20EE550@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Cina Hazegh <chazegh@flashmob.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Cina,

 Probably, you already know the OSK5912, don't you?

	http://omap.spectrumdigital.com/osk5912/

 If you are looking forward to making the board itself, here
is the check list for you.

 - Comfortable with 6 ~ 10 layers design?
 - Comfortable with > 50 MHz signal routing?
 - Comfortable with  1.6[V] design for 50 ~150 [mA]?
 - Able to solder the BGA package?
 - Able to obtain the DDR for your quantity?
   (The LCD would be next difficult to get, if you plan it)
 - Do you (or your friend) have JTAG tools?

 If you are positive for these items, I believe you enjoy the
work itself, and it should be good experience.

 As for the device, try the OMAP5912, which is available
through the digi-key.

 Good luck,
 Ishigami

-----Original Message-----
From: Cina Hazegh
Sent: Friday, March 24, 2006 6:55 AM
To: linux-omap-open-source@linux.omap.com
Subject: OMAP development on a student budget

Many apologies if this sort of question has been asked many times =20
before, but I haven't been able to find this information on the web =20
or in this lists' archives, so I am going to ask.

I am very interested in developing my own PCB that incorporates an =20
OMAP processor. Does anyone on this list have any experience with =20
doing this sort of thing, and if so, what does it take? Is it a =20
reasonable task for someone with some solid PCB layout experience?

If so, which processors would I be able to obtain on a student =20
budget? I've been able to find the OMAP5910 through Digi-key, but I'm =20
interested in designing a board for one of the newer processors, =20
since TI is warning that new designs should not be done for the 5910 =20
(which means to me that it will be discontinued soon).

I should point out, that my final goal is to provide the board layout =20
and schematic in an open source fashion for other students and =20
developers to learn from. Any help/information/guidance you can =20
provide would be appreciated.

-- Cina Hazegh


___________________________________________________
Cina Hazegh, Graduate Student
University of California, Irvine --  Arts, Computation and Engineering
chazegh@uci.edu  |  http://cinahazegh.com | http://opencircuits.com

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
