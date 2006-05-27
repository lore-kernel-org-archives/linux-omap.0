From: Stefan Roese <ml@roese.nl>
Subject: Re: Kernel panics on OSK5912
Date: Sat, 27 May 2006 08:18:30 +0200
Message-ID: <200605270818.30543.ml@roese.nl>
References: <20060526063240.84781.qmail@web52306.mail.yahoo.com>
	<200605260908.03332.ml@roese.nl>
	<20060526220755.GG4132@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060526220755.GG4132@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com, Eduardo Gallofin <egallofin@yahoo.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Saturday 27 May 2006 00:07, Tony Lindgren wrote:
> > We experienced similar problems on our OSK5912. The problems are SDRAM
> > setup related and can be solved by updating to the latest U-Boot version.
> > Please download and install the top-of-git version and give it a try.
>
> Anybody have a patch to check this in the board-osk.c? This bug seems to
> occur repeatedly so it would be nice to patch it away in the kernel
> also.

I don't think this would work. SDRAM setup has to be done correctly in the 
bootloader (U-Boot or whatever is used) and can't be corrected later on by 
linux itself.

Best regards,
Stefan
