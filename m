From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Linux audio driver OMAP5912
Date: Thu, 6 Apr 2006 07:51:41 -0500
Message-ID: <520AB2AD990DC04082102F77CA17263810371F@dlee03.ent.ti.com>
References: <OF24DCAEEA.2584161E-ON65257148.00371CD2-65257148.00377BD1@tcs.com>
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
To: ruchir.gulati@tcs.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Ruchir,
>mono speech sampled at 8KHz and uses 16 bits/sample resolution.
Some of the codecs do not support Mono mode of data. the behavior of =
playing a mono data on a stereo line is expected to be playing fast. if =
you can check out http://www.opensound.com/pguide/oss.pdf, the IOCTLs =
required to put the codec into mono mode are listed there. if the ioctls =
fail, it is a fair assumption that that the device does not support mono =
mode.
=20
One trick to work around this is as follows: have a mono sample at x khz =
and configure the codec at (x/2) khz (provided it is supported on the =
codec).
=20
Regards,
Nishanth Menon
