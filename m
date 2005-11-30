From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: DSP core access
Date: Wed, 30 Nov 2005 15:31:50 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402B6B5CF@dlee02.ent.ti.com>
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
To: Louis Jung <lhsj81@gmail.com>
Cc: Toshihiro.Kobayashi@nokia.com, linux-omap-open-source@linux.omap.com, comunerito@yahoo.com
List-Id: linux-omap@vger.kernel.org

Hi Louis,
=09
> =09
> Sorry for continuous postings on the same topic, but I am very new to
this OMAP development area and was hoping to grab all the help that can
be=20
> provided.
> Currently my major problem seems to be on using non-montavista linux.
The CCS approach seems to have ways around non-montavista linux. However
the Linux > DSP tools seems to be montavista linux specific. It seems to
me that the tools are using binaries that are specifically provided by
montavista, if I am > wrong could someone give me a hand in configuring
the $DSPLINK/make/Linux/osk5912_mvlpreviewkit3.1.mk ? I can't not really
find replacements for
> 	-BASE_CGTOOLS :=3D /opt/montavista/previewkit/arm/v4t_le/bin
> 	-BASE_OSLIB :=3D /opt/montavista/previewkit/arm/v4t_le/lib
> 	which I assume are necessary for C55xx DSP code generation.

>From my understanding the above definitions are not needed for compiling
the DSP portion of dsplink. Please note that dsplink consists of a
kernel module that runs on the arm and a dsp/bios driver that runs on
the dsp. With regard to the above, if you are not using the montavista
tools, then this is where you should specify what build tools you are
using for the arm to build the kernel module and arm side dsplink
applications.=20

Regards,
Jon

=09
=09
