From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Question about microphone usage on OMAP2430SDP
Date: Tue, 23 Jan 2007 20:04:22 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47148111@dlee13.ent.ti.com>
References: <dbf1574b0701231757o7186a24dk39d9483ae371eab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <dbf1574b0701231757o7186a24dk39d9483ae371eab5@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: RobertChou <rbtchc@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

What is the version of your 2430 SDP? It will be printed on MMC slot-1.

Regards,
Khasim

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of RobertChou
> Sent: Tuesday, January 23, 2007 7:58 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Question about microphone usage on OMAP2430SDP
>=20
> hi,
>=20
>   I'm trying to record some voice through Main/Sub & Headset
microphone on
> OMAP2430SDP board. But only noises is recorded (does not sound like
> voice).
>=20
>   I have used
>     1. cat /dev/dsp > audio.out & cat audio.out > /dev/dsp   -->
failed
>     2. sample program from pjsip (open source sip protocol stack)
>         which config. sample rate=3D44100, ch=3D2, bits=3D16
>         (able to record sound in x86 system)
-->
> failed
>=20
>    Besides main/sub mic, I noticed that the record source can be
switch to
> Headset by ioctl OSS driver. I tried to use audio connector to 3.5mm
> microphone
> to the headset plug. But still doesn't work.
>=20
>    I'm using linux-2.6.14-omap2430 downloaded from TI webiste. Does
anyone
> ever
> successfully record anything from OMAP2430 main/sub or headset mic?
And
> how
> can i correctly connect microphone to on-board headset plug? I'm
currently
> using
> audio connector grab from nokia mobile accessory. Thx for answering my
> question.
>=20
> Best Regards,
>=20
> Robert
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
