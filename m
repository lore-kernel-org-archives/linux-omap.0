From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] SD working on OMAP platforms
Date: Tue, 03 Apr 2007 06:37:28 +0200
Message-ID: <4611DA08.7020102@drzeus.cx>
References: <460D72E0.7050206@indt.org.br> <460DFCB9.4070102@drzeus.cx>
	<460EDBAC.9050301@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <460EDBAC.9050301@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>, ext Philip Langdale <philipl@overt.org>
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> On CMD3, response type is R6 to SD cards and R1 to MMC cards.
> This fix ignores the buggy SD handling on CMD3.
>
>   

This is misleading. The problem is the OMAP controller trying to be
smart with the end result of it doing something completely wrong. The
controller parses data when it has no idea what we want parsed.

> +		if (status == 0x4000) {
> +			dev_dbg(mmc_dev(host->mmc),
> +				"buggy SD handling, ignoring it\n");
> +			status = 0x0001;
> +		}
> +
>   

Some defines for those constants would be nice. And the debug message
should be more general

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
