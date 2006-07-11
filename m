From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: OMAP 730: I2S driver
Date: Tue, 11 Jul 2006 09:10:47 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E42A437@DLEE09.ent.ti.com>
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
To: chetan.kapoor@flextronicssoftware.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>=20
> Kindly help if you have come across or know of any open source
> implementation of the I2S driver on OMAP 7xx. I tried searching in the
U can consider using McBSP driver for I2S protocol. This is the normal
connectivity on OMAP16xx and OMAP24xx platforms.
Regards,
Nishanth Menon
