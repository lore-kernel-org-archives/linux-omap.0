From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] drivers: spi: Add qspi flash controller
Date: Tue, 2 Jul 2013 15:56:57 +0530
Message-ID: <51D2AAF1.4080803@ti.com>
References: <1372755399-21769-1-git-send-email-sourav.poddar@ti.com>
	<20130702093247.GY27646@sirena.org.uk>
	<20130702094404.GL3352@arwen.pp.htv.fi>
	<20130702101718.GE27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130702101718.GE27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,
On Tuesday 02 July 2013 03:47 PM, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 12:44:04PM +0300, Felipe Balbi wrote:
>> On Tue, Jul 02, 2013 at 10:32:47AM +0100, Mark Brown wrote:
>>> Does this hardware really support anything other than 8 bits per word?
>>> There is no code in the driver which pays any attention to the word
>>> size...
>> the HW has a 128-bit shift register ;-) but driver doesn't look
>> complete.
> That's not the issue - remember that SPI specifies big endian byte
> ordering for words on the bus so things will need to be reordered by the
> hardware for anything except 8 bits.
Yes, I defaulted my driver to assume 8 bits.
I will introduce case by case reads based on t->len

Something like..
case 8:
    readb();
case 16:
    readw();
case 32:
    readl();


~Sourav

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
