From: Vineet Tuli <vineet@cybernetra.com>
Subject: Re: Usb printing thru omap5912
Date: Tue, 17 Jan 2006 16:26:14 +0530
Message-ID: <1137495375.2532.16.camel@meenakshi.linux>
References: <1137324187.3427.2.camel@meenakshi.linux>
	<20060116184307.GH4511@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060116184307.GH4511@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <linux-omap-open-source@linux.omap.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony

Thankx a lot Actually my printer is detected properly but i am on the
lookout for some printing tools for ARM.

Vineet Tuli

On Mon, 2006-01-16 at 10:43 -0800, Tony Lindgren wrote:
> * Vineet Tuli <vineet@cybernetra.com> [060115 13:14]:
> > Hi.
> > 
> > Has anybody been able to print using a usb printer using omap5912?
> > 
> > Please Guide.
> 
> Pretty much all Linux USB stuff should work on OSK. If you have
> problems, please make sure that you have CONFIG_OMAP_RESET_CLOCKS
> disabled in your .config file.
> 
> Tony
