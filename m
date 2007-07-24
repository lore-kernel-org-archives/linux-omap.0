From: "Krishna Prasad Herur" <kherur@nextwave.com>
Subject: RE: Trouble downloading bootloader using CSST onto 2430SDP
Date: Mon, 23 Jul 2007 18:45:10 -0700
Message-ID: <E6CCDC65B8C522458685D8D1F145FEA89E34DC@CA2-MSX-C01.nw.net>
References: <E6CCDC65B8C522458685D8D1F145FEA89E330E@CA2-MSX-C01.nw.net>
	<B62D67BD8EC3324C8A3DACEEA1A0D6C6020E0328@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <B62D67BD8EC3324C8A3DACEEA1A0D6C6020E0328@dlee12.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Aah, you are right. I do have 5.0 SDP, and the documentation does say
UART not supported. I will try with the latest CSST tool.
Thanks,
-Prasad

-----Original Message-----
From: Kipisz, Steven [mailto:s-kipisz2@ti.com]=20
Sent: Monday, July 23, 2007 6:27 PM
To: Krishna Prasad Herur; linux-omap-open-source@linux.omap.com
Subject: RE: Trouble downloading bootloader using CSST onto 2430SDP

If I am correct, you cannot use UART3 for downloading or using CSST with
the 5.0 SDP.  Only USB is available.  Can you check your CSST
documentation to see if it supports the 5.0 SDP?  If it does not mention
5.0 SDP you might want to get a newer version of CSST.  I think it is up
to 1.11.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Krishna Prasad Herur
Sent: Monday, July 23, 2007 5:18 PM
To: linux-omap-open-source@linux.omap.com
Subject: Trouble downloading bootloader using CSST onto 2430SDP

Hi,

 I am using Omap2430 SDP v5.0.1, and CSST 1.9.0.3. I am not able to get
CSST to connect to the SDP (in Monitor mode) using UART or HS USB.=20

=20

I am using the CSST tool in Monitor mode, and I click on the Connect
button. For UART I get a message saying "Could not get module info from
target. Possible timeout." For USB I get the message, "Error
establishing connection to target. Possible timeout".=20

=20

I am thinking there is an issue with my dip switch setting. I am using
the default Dip Switch settings provided in the QuickStart guide, which
seems to indicate that it should enable UART3 (J9). I have looked at
this document created by Nishanth at
http://www.geocities.com/crecmca98/Linux/omap2430_From_almost_scratch.pd
f

=20

The LCD on the main board displays "**Flash Boot** Led =3D 0x0000" Is =
this
what I am supposed to see before downloading the bootloader? If anyone
can confirm my dip switch settings (below), that would help me a lot.

Thanks,

-Prasad

=20

=20
+-----------------------------------------------------------------------
---+
   |S10                                   |        |        |        |
|
=20
|--------------------------------------+--------+--------+--------+-----
---|
   |    1    | =06  2    |    3    |   4    |        |        |        |
|
=20
|---------+---------+---------+--------+--------+--------+--------+-----
---|
   |   ON    |   ON    |   ON    |   ON   |        |        |        |
|
=20
|-----------------------------------------------------------------------
---|
   |S9
|
=20
|-----------------------------------------------------------------------
---|
   |    1    |    2    |    3    |   4    |   5    |   6    |   7    |
8    |
=20
|---------+---------+---------+--------+--------+--------+--------+-----
---|
   |   ON    |   OFF   |   ON    |   OFF  |   OFF  |   ON   |   ON   |
OFF   |
=20
|-----------------------------------------------------------------------
---|
   |S8
|
=20
|-----------------------------------------------------------------------
---|
   |    1    |    2    |    3    |   4    |   5    |   6    |   7    |
8    |
=20
|---------+---------+---------+--------+--------+--------+--------+-----
---|
   |   ON    |   ON    |   ON    |   ON   |   ON   |   ON   |   OFF  |
ON    |
=20
|-----------------------------------------------------------------------
---|
   |S6
|
=20
|-----------------------------------------------------------------------
---|
   |    1    |    2    |    3    |   4    |   5    |   6    |   7    |
8    |
=20
|---------+---------+---------+--------+--------+--------+--------+-----
---|
   |   ON    |   ON    |   OFF   |  OFF   |  ON    |  OFF   |  OFF   |
ON   |
=20
|-----------------------------------------------------------------------
---|
   |S4
|
=20
|-----------------------------------------------------------------------
---|
   |    1    |    2    |    3    |   4    |   5    |   6    |   7    |
8    |
=20
|---------+---------+---------+--------+--------+--------+--------+-----
---|
   |   OFF   |   OFF   |   OFF   |  OFF   |   ON   |   ON   |  OFF   |
OFF   |
=20
+-----------------------------------------------------------------------
---+
=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
