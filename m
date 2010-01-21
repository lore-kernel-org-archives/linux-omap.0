From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: Re:
Date: Thu, 21 Jan 2010 09:04:30 +0900
Message-ID: <4B579A0E.4030108__299.369081813161$1264032479$gmane$org@simtec.co.uk>
References: <1264016711-sup-309@ben-laptop>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f89b7ef7f840047da17bbb
Return-path: <3r5pXSwMMC-wPSbgWahSQ.Qc.iYPSOUZSPcOfRUccUZSUfcidg.Qca-JX7+OpRa80S8N/ZHIG5xj07CuiCeIGUxQQ4Iyu8u01E@public.gmane.org>
In-Reply-To: <1264016711-sup-309@ben-laptop>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=>,
	<mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=>,
	<mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=>,
	<mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Ben Gamari <bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: beagleboard <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--001485f89b7ef7f840047da17bbb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ben Gamari wrote:
> Bcc: 
> Subject: GPIO chip select support in omap2_mcspi driver
> 
> Hey,
> 
> Recently I have been looking to use a BeagleBoard to drive several
> serial ADCs and DACs in a data acquisition and analysis setup. Unfortunately, the
> BeagleBoard is severely limited by the number of SPI controllers it
> exposes on the expansion connector (McSPI3 with 2 CS lines and McSPI4
> with one). This is insufficient for our application and thus I have been
> investigating adding support to the mcspi driver for using GPIO lines as
> chip select lines, as is done in the pxa2xx, bfin5xx, and s3c24xx drivers.
> 
> To this end, I have a few questions about how this support was
> implemented. First, it seems that the s3c24xx driver is built on the
> spi_bitbang driver, despite interfacing with a dedicated hardware SPI
> controller.  What is the reason for this? Was this done specifically for
> the purpose of incorporating support for GPIO CS pins?

The spi_bitbang driver also has a really useful spi queue and workqueue
built into it, which is what the s3c24xx spi driver actually bothers to
use.

> It seems like the rough idea is to add a cs_gpio field to the device
> struct (omap2_mcspi) and add the appropriate code to the
> omap2_mcspi_force_cs() to bring cs_gpio high or low if it is valid. The
> potential problem I can see with this is that omap2_mcspi_set_enable()
> is called to enable the channel before the force_cs() is called (in
> omap2_mcspi_work()). If I'm interpreting the documentation correctly,
> the enable bit starts the clocks, meaning that the chip will begin
> clocking out data before CS is brought high. I must be missing something
> here, no?
> 
> For reference, I included a short list of relevant commits below, largely for
> my own benefit. I would greatly appreciate any feedback you might have.
> 
> Thanks,
> - Ben
> 
> 
> pxa2xx_spi: a7bb3909b3293d503211d7f6af8ed62c1644b686
> bfin_spi: 42c78b2bf51bafb4cfa98dfecc28dd9b8bcd04b0


--001485f89b7ef7f840047da17bbb
Content-Type: text/plain; charset=ISO-8859-1

-- 
You received this message because you are subscribed to the Google Groups "Beagle Board" group.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/beagleboard?hl=en.



--001485f89b7ef7f840047da17bbb--
