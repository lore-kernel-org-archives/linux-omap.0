From: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: about OMAP usb Speed?
Date: Thu, 12 Apr 2007 15:30:04 +0200
Message-ID: <200704121530.04125.marek.vasut@gmail.com>
References: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
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

Yeah, right ... as some people here said, it's impossible per default to ma=
ke=20
it support usb2. I now have board with Cypress SX2 controller which is quit=
e=20
simple to understand and adds usb2.0 gadget support. Also Cypress put out a=
ll=20
datasheets and even a example of driver for VxWorks (written in C; vxworks =
=2D=20
embedded "os"). Im now working on driver for that SX2, but I also have a lo=
t=20
of school so it can take long.

BR
Marex

Dne =C4=8Dtvrtek 12 duben 2007 02:28 Wael Adel napsal(a):
> hi all,
> i have an OMAP-OSK5912, as for its usb bus i know that it is a
> full-speed (12Mbps)
> isnt there any way or any patch that make it support for high-speed
> (240Mbps)?
>
> or it is an impossible to do that?
> if it is impossible tell me why please?
>
> thanks in advance
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
