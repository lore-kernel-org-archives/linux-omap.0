From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: TSC2101/2102
Date: Thu, 15 Mar 2007 10:18:14 +0900
Message-ID: <002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-reply-to: <20070314170952.GB10230@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Imre Deak' <imre.deak@solidboot.com>, 'Nishanth Menon' <menon.nishanth@gmail.com>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> 
> On Wed, Mar 14, 2007 at 08:21:24AM -0500, Nishanth Menon wrote:
> > andrzej zaborowski stated on 3/9/2007 8:23 AM:
> > > On 09/03/07, Imre Deak <imre.deak@solidboot.com> wrote:
> > >> I'm wondering about the proper way to convert the existing 
> > >> omap-tsc2101 driver to the SPI framework. Would it make sense to 
> > >> handle it with the
> > >> tsc2102 driver? omap-tsc2101 has only the register read / write 
> > >> interface which is the same as in tsc2102.
> > >
> > > How about maybe a header file <linux/spi/tsc2xxx.h> shared between
> > > tsc2101/2102 with the register access functions as "static inline"
> > > functions?
> > Some TODOs:
> > 1. should interrupt muxing be done here?
> > 2. There are some TSC2005 devices(TS only).. so it will be 
> interesting 
> > to see xxxx.h scales to all..
> > 3. rename this to tsc2xxx_core.[ch]
> > 4. use SPI framework (would not break uwire support I believe).
> 
> The attached patches try to do #4. Please review it / sign it 
> off as necessary.
> 
> There is an upcoming TSC2301 patch, that should also be taken 
> into account when creating a tsc2xxx-core.[ch] based on the 
> existing TSC driver implementations.
> 

Cool!!!

In the previous time, I implemented the tsc2101 on OMAP2 based on tsc2301.
[1]
The current code only supports 16-bit tsc2101 for OMAP1.
We have to consider OMAP2 tsc2101 for H4 and apollon.

Here's simple changes.

+struct tsc2101_platform_data {
+       int     (*init)(struct spi_device *spi);
+       void    (*cleanup)(struct spi_device *spi);
+       void    (*enable_mclk)(struct spi_device *spi);
+       void    (*disable_mclk)(struct spi_device *spi);

+       int       bits_per_word;

+};

How about to add 'bits_per_word' to platform. So if the bits_per_word is
empty. it assumes it will use 16-bit, otherwise we use it provided from
platform.

+struct tsc2101_device {
+       struct mutex            mutex;
+       int                     mclk_enabled;
+       struct clock            *mclk_ck;
+       struct spi_message      message;
+       struct spi_transfer     transfer[2];
+       u16                     command;
+       void                    (*enable_mclk)(struct spi_device *spi);
+       void                    (*disable_mclk)(struct spi_device *spi);

+       int		32bit_shift;	/* 16 if 32-bit bus, otherwise 0 */

+};

Please change the command from u16 to u32. Umm, I'm not sure we have to
change the parameter from u16 *data to u32 *data.

I will check it.

Thank you,
Kyungmin Park

1. http://linux.omap.com/pipermail/linux-omap-open-source/2007-
January/008933.html
