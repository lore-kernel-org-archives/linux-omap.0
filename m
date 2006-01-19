From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: configuration problem with innovator 1510 & tsc2101
Date: Thu, 19 Jan 2006 10:28:51 -0600
Message-ID: <99E943D7AA8E3A448619E1F809F2A2A201160E00@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Dirk Behme <dirk.behme@de.bosch.com>, Mikko.Soikkala@Tietoenator.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The Innovator 1510 uses an ADS7846 touch screen controller so it does
not use the tsc2101.

Steve Kipisz

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Dirk
Behme
Sent: Thursday, January 19, 2006 10:04 AM
To: Mikko.Soikkala@Tietoenator.com
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: configuration problem with innovator 1510 & tsc2101

Mikko.Soikkala@Tietoenator.com wrote:
> Is omap-tsc2101.c supposed to be compiled in 1510 innovator
environment?

If I remember correctly touchscreen is set to unsupported for 1510=20
because nobody has tested it.

If it is working for you and you tested it, a patch is welcome ;)

Regards

Dirk
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
