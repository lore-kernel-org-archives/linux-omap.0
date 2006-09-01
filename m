From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] TSC2102 OMAP audio driver
Date: Fri, 1 Sep 2006 15:40:03 -0700
Message-ID: <200609011540.04066.david-b@pacbell.net>
References: <fb249edb0608180329k519d3355x7707fcadbddeefee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608180329k519d3355x7707fcadbddeefee@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, balrogg@gmail.com
List-Id: linux-omap@vger.kernel.org

On Friday 18 August 2006 3:29 am, andrzej zaborowski wrote:
> +config SND_OMAP_TSC2102
> +       tristate "OMAP TSC2102 alsa driver"
> +       depends on ARCH_OMAP && SND
> +       select SND_PCM
> +       select TSC2102
> +       select SPI_OMAP_UWIRE

Don't select SPI_OMAP_UWIRE, there's no reason it couldn't be
used with one of the other SPI controllers ...
