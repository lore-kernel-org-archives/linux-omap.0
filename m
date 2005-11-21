From: Matthew Percival <matthew@capgo.com>
Subject: Re: OSK5912 USB Port Problem
Date: Tue, 22 Nov 2005 09:14:07 +1100
Message-ID: <1132611247.8832.11.camel@localhost.localdomain>
References: <437d78ad.1c0496aa.28bc.29a8@mx.gmail.com>
	<1132524761.8816.8.camel@localhost.localdomain>
	<43819DED.9030102@uma.es> <20051121174914.GA7680@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051121174914.GA7680@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> I've noticed that having CONFIG_OMAP_RESET_CLOCKS on kills OHCI at least
> on OSK. Juha's patch from few months ago probably helps with that as it
> turns on dc_clk:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html
> 
> Can you please check if it's caused by this combination? We should get
> Juha's patch integrated...

	I just tried removing CONFIG_OMAP_RESET_CLOCKS, and everything worked
as expected.  If I apply the above patch, then restore
CONFIG_OMAP_RESET_CLOCKS, then things still work: seems to be a Good
Thing.

	-- Matthew
