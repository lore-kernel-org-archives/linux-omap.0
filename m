From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 4/7
Date: Tue, 21 Feb 2006 08:25:12 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726381036F1@dlee03.ent.ti.com>
References: <20060221141424.95300.qmail@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Komal Shah <komal_shah802003@yahoo.com>, Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

=20
>Does it mean, that you have added the code in 2430 port which does
>above stuff, means dynamic setting for McBSP from platform data? _or_
>You want to mention that McBSP settings for particular board and codec
>combination remains same.
yes. the touple (mcbsp config,codec, board) remains constant. the probe =
of the codec should take care of detecting if the device is actually =
present or not. dynamic settings from mcbsp default settings defined in =
platform data is required for the following cases:
1. when the device switches mode of data transfer - such as moving from =
16 bit to 24 bit
2. trying to do "pseudo" mono data transfer where the input data is in =
mono and this needs to be duplicated at i2s level so that the codec does =
a stereo output.
=20
Regards,
Nishanth Menon
