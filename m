From: Ben Gamari <bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: (no subject)
Date: Wed, 20 Jan 2010 14:47:23 -0500
Message-ID: <1264016711-sup-309@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, beagleboard <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Bcc: 
Subject: GPIO chip select support in omap2_mcspi driver

Hey,

Recently I have been looking to use a BeagleBoard to drive several
serial ADCs and DACs in a data acquisition and analysis setup. Unfortunately, the
BeagleBoard is severely limited by the number of SPI controllers it
exposes on the expansion connector (McSPI3 with 2 CS lines and McSPI4
with one). This is insufficient for our application and thus I have been
investigating adding support to the mcspi driver for using GPIO lines as
chip select lines, as is done in the pxa2xx, bfin5xx, and s3c24xx drivers.

To this end, I have a few questions about how this support was
implemented. First, it seems that the s3c24xx driver is built on the
spi_bitbang driver, despite interfacing with a dedicated hardware SPI
controller.  What is the reason for this? Was this done specifically for
the purpose of incorporating support for GPIO CS pins?

It seems like the rough idea is to add a cs_gpio field to the device
struct (omap2_mcspi) and add the appropriate code to the
omap2_mcspi_force_cs() to bring cs_gpio high or low if it is valid. The
potential problem I can see with this is that omap2_mcspi_set_enable()
is called to enable the channel before the force_cs() is called (in
omap2_mcspi_work()). If I'm interpreting the documentation correctly,
the enable bit starts the clocks, meaning that the chip will begin
clocking out data before CS is brought high. I must be missing something
here, no?

For reference, I included a short list of relevant commits below, largely for
my own benefit. I would greatly appreciate any feedback you might have.

Thanks,
- Ben


pxa2xx_spi: a7bb3909b3293d503211d7f6af8ed62c1644b686
bfin_spi: 42c78b2bf51bafb4cfa98dfecc28dd9b8bcd04b0

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
