From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Qeury regarding EAC driver for omap 24xx
Date: Wed, 06 Jun 2007 16:51:51 +0400
Message-ID: <4666ADE7.5050904@gmail.com>
References: <61445c750706060402q34388d3fm7bf2c097b34f6346@mail.gmail.com>
	<20070606150430.e4d55f5c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070606150430.e4d55f5c.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Jarrko,

Jarkko Nikula wrote:
> I think drivers in sound/arm/omap are somewhat "adrift". Codec drivers
> are tightly coupled into OMAP, they implement same global functions so
> that you cannot link them together, no clear separation between audio
> controller and codec, etc.
>
> Hopefully we see gradually those drivers ported into ASoC platform and
> codec drivers in order to get some change to get them into mainline.
>
yes, it would be great to port sound/arm/omap stuff to ASoC framework,
do you have any plans (or maybe already working) on this?

Thanks,
Dmitry
