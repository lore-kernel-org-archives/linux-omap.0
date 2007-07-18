From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Problem with McSPI as Slave
Date: Wed, 18 Jul 2007 18:47:12 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47015D4753@dlee13.ent.ti.com>
References: <E6CCDC65B8C522458685D8D1F145FEA8975C8F@CA2-MSX-C01.nw.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA8975C8F@CA2-MSX-C01.nw.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Krishna Prasad Herur <kherur@nextwave.com>, Timothy Tang <ttang@ktrc-na.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>
>I have had an issue with the length of the cable used to drive the
>slave. The Omap2430 Spi master was not able to drive an external SPI
>slave when my cable was longer than 10-12 inches.
>
>Have you tried looping back data from one SPI instance to the other on
>the same processor?
>-Prasad
>
>

One thing that I wanted to know is the count of people who are =
interested in SPI Slave support for OMAP. I had started working on this =
and we had some initial discussions on SPI development list. But then =
stopped as it was not interested to many.

If you guys really need this then we can work on adding additional =
structure for slave to SPI stack and get the driver modified to support =
the same.

Interested_count_for_now =3D 3. If it reaches 5, I will work on this :)

Regards,
Khasim
