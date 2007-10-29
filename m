From: "arun c" <arun.edarath@gmail.com>
Subject: Re: touch screen on 2430sdp not giving X and Y values
Date: Mon, 29 Oct 2007 12:00:27 +0530
Message-ID: <c656a4d20710282330x74dc71e0x68ca6c5309c3b643@mail.gmail.com>
References: <c656a4d20710260532wb60aa47r369f80c3c58c946a@mail.gmail.com>
	<000901c817e9$83f48c80$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <000901c817e9$83f48c80$6a8918ac@ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/26/07, Girish <girishsg@ti.com> wrote:
>
>
> >-----Original Message-----
> >From: linux-omap-open-source-bounces@linux.omap.com
> >[mailto:linux-omap-open-source-bounces@linux.omap.com] On
>
> >Subject: touch screen on 2430sdp not giving X and Y values
> >
> >Hi all,
> >
> >I am working on 2430sdp. I am using the kernel linux-2.6.14-omap2-v4.
> >
> >I wanted to use the touch screen on sdp. I built the kernel
> >using the default configuration came with the kernel source.
> >
> Check in menu config whether OMAP SPI is enabled and see
> Touch Screen interface power is enabled.

I checked it and it is enabled as given below

#
# Synchronous Serial Interfaces (SSI)
#
CONFIG_OMAP_MCBSP=y
CONFIG_OMAP_MCSPI=y
CONFIG_OMAP_HDQ=y

But how can i check the Touch Screen interface power???  you mean
hardware wise checking??
>
> >I downloaded the evtest.c from net to test the touch screen.
> Try enabling debug statements in the driver(if exists or you can
> put some debug statements for printing x y & z).
I will put debug messages and let you know.

regards
arun
