From: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: OMAP 730 audio driver
Date: Thu, 17 May 2007 17:32:03 +0200
Message-ID: <200705171732.04024.marek.vasut@gmail.com>
References: <61445c750705170728ubbf884cn1b34df8f196834ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <61445c750705170728ubbf884cn1b34df8f196834ea@mail.gmail.com>
Content-Disposition: inline
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

Hi, it'd be nice if they are alsa compliant since OSS is dead ;-) Dunno=20
whether there are some drivers yet, but try checking htc magician/wizard (o=
ne=20
of those) linux port, they are also 730 based iirc

br
Marex

Dne =C4=8Dtvrtek 17 kv=C4=9Bten 2007 16:28 Pharaoh . napsal(a):
> Hi,
> I am working on OMAP 730 based p2-sample board. AFAIK, there is no audio
> driver support for this board. I have found
> 2.4 drivers for the same board which I have ported to 2.6, but it is an O=
SS
> driver.
>
> So, the question:
> 1. Do I need to migrate these drivers to be ALSA compliant?
> 2. Has anyone written ALSA drivers for the above mentioned board? Any
> pointers will be helpful regarding the same.
>
>
> -pharaoh.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
