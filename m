From: Jose Manuel Cano Garcia <jcgarcia@uma.es>
Subject: Re: OSK5912 USB Port Problem
Date: Thu, 24 Nov 2005 13:45:56 +0100
Message-ID: <4385B604.2060404@uma.es>
References: <437d78ad.1c0496aa.28bc.29a8@mx.gmail.com>
	<1132524761.8816.8.camel@localhost.localdomain>
	<43819DED.9030102@uma.es> <20051121174914.GA7680@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051121174914.GA7680@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I had some time to test the patch with the latest kernel I could get 
with git (I think its 2.6.15-rc2 now). With that patch USB works OK. I 
think someone has tested it about a day before, but this it to confirm 
that it really works.

This is great for me because 2.6.11 had not driver support for the 
OSK5912 sound device.

Thanks,

Jose Manuel

>I've noticed that having CONFIG_OMAP_RESET_CLOCKS on kills OHCI at least
>on OSK. Juha's patch from few months ago probably helps with that as it
>turns on dc_clk:
>
>http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html
>
>Can you please check if it's caused by this combination? We should get
>Juha's patch integrated...
>
>Tony
>
>.
>
>  
>
