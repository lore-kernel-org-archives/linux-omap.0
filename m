From: ml@roese.nl
Subject: Re: 1710 and USB host
Date: Mon, 10 Jul 2006 17:02:35 +0200
Message-ID: <200607101702.35934.ml@roese.nl>
References: <44564B38.9020802@mvista.com>
	<200605022211.05662.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605022211.05662.david-b@pacbell.net>
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
To: linux-omap-open-source@linux.omap.com
Cc: Kevin Hilman <khilman@mvista.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Wednesday 03 May 2006 07:11, David Brownell wrote:
> > isp1301_omap 0-002d: chiprev 2.00, driver 24 August 2004
> > MUX: initialized N21_1710_GPIO14
> > usbmon: debugfs is not available
> > isp1301_omap 0-002d: A-Host sessions ok
> > ohci ohci: OMAP OHCI
> > ohci ohci: new USB bus registered, assigned bus number 1
> > ohci ohci: irq 38, io mem 0xfffba000
> > ohci ohci: init err (00000000 0000)
>
> That "init err" means the controlle wasn't responding to basic stuff.
> Like maybe it wasn't clocked correctly ... you could turn on USB_DEBUG
> in Kconfig and see if the register dump looks even vaguely sane (like,
> it should report three ports etc).

We have a custom 1710 based board and I see exactly the same error message. 
Did you solve your problems with the "init err" on the 1710 platform? If yes, 
what was the solution. Thanks for any input here.

Best regards,
Stefan
