From: "Hingkwan Huen" <hkh@cypress.com>
Subject: RE: patchs commits
Date: Thu, 9 Nov 2006 14:08:35 -0800
Message-ID: <002601c7044b$9d359020$818310ac@mis.cypress.com>
References: <20061109210818.0B8C11DA2C0@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061109210818.0B8C11DA2C0@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'David Brownell' <david-b@pacbell.net>, tony@atomide.com
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

MMC seems to work on H4 with 2.6.16 kernel with the OMAP2 patch, except if
you eject and re-install the card, you have to reboot the board. 
At least that's what I am currently using right now.

-Kwan

-----Original Message-----
From: David Brownell [mailto:david-b@pacbell.net] 
Sent: Thursday, November 09, 2006 1:08 PM
To: tony@atomide.com; hkh@cypress.com
Cc: Linux-omap-open-source@linux.omap.com
Subject: Re: patchs commits

> 	 MMC is probably currently
> broken for Menelaus, but there are some patches coming for that.

On at least one H4 board, it seems to not come up ... :)

- dave
