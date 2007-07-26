From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [RFC 1/2] MMC/SD Controller driver for OMAP2430
Date: Thu, 26 Jul 2007 14:57:46 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47016A390A@dlee13.ent.ti.com>
References: <20070726095717.GC27453@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070726095717.GC27453@flint.arm.linux.org.uk>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Russell,

>On Wed, Jul 25, 2007 at 07:17:06PM -0500, Syed Mohammed, Khasim wrote:
>> I am hereby presenting MMC/SD controller driver for OMAP 2430. It has
>> been validated for SD/MMC (3v) cards on 2430 (ES 2.1) SDP V4.0.
>
Many thanks for all your comments, I will incorporate them and re-post =
the patches.

>Also, please explain how this is different to the existing omap driver,
>and why the existing omap driver can not support this.

Existing OMAP MMC controller driver works for OMAP 1 (1510 to 1710) and =
OMAP2 (2420 only) platforms as they had similar MMC controller, the =
controller changed from OMAP2430 onwards. The changes are mainly at =
register and bit level that makes things bit complicated when we try to =
integrate them together.

For example: In OMAP1 MMC controller there is a separate busy bit to be =
set for R1B response which on 2430 exists in a totally different =
register in a different way. There are many such instances.

And specifications vise, new controller supports 8 bit, fully compatible =
with latest specs, etc. And new boards support dual voltage cards, multi =
slot etc.=20

Testing for driver compatibility with older platforms will also be bit =
difficult as most of us don't have older platforms.

It will be really hard for us to integrate New MMC controller driver =
with existing OMAP1 MMC controller driver. Hope you will consider our =
request for adding new file for latest MMC controller.=20

Please do let me know if you have another opinion.

Thanks & Regards,
Khasim
