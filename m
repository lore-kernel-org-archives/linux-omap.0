From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/14] MMC: OMAP: Add MMC multislot support
Date: Tue, 9 Oct 2007 08:34:36 -0700
Message-ID: <20071009153436.GD7784@atomide.com>
References: <46F28BA0.3080002@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46F28BA0.3080002@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [070920 08:04]:
> Hi Tony and folks,
> 
> This is the latest 'MMC: OMAP: Add MMC multislot support' patch series
> with changes, corrections and improvements based on comments and
> suggestions from community (mainly Tony, Brownell and Trilok) and coworkers.
> 
> Just to remind you, this patch series adds the MMC multislot support for
> N800 and TI OMAP H2 and H3 boards. It's based on Juha's and Jarkko's
> earlier implementation and it can be applied against most updated
> linux-omap tree (2.6.23-rc6-omap1).
> 
> I've tested with MMC, SD and SDHC cards and looks fine for the boards
> mentioned above.
> 
> Testing, comments and suggestions are welcome.

Any news on using these patches on 1510? There are several 15xx based
boards where the only root is MMC, so we should make sure it works on
15xx before applying these.

Regards,

Tony
