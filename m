From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] keypad: platform_data and 24xx support -exp
Date: Fri, 20 Jan 2006 15:02:57 -0800
Message-ID: <20060120230257.GC6683@atomide.com>
References: <20051210130228.91620.qmail@web32905.mail.mud.yahoo.com>
	<20060114003728.GJ5499@atomide.com> <43C85C21.6030202@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43C85C21.6030202@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lamikr <lamikr@cc.jyu.fi>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Mika,

* lamikr <lamikr@cc.jyu.fi> [060113 17:57]:
> Has anybody needed a joypad driver for the omap-boards? 
> I have made changes to keypad driver so that it will support h6300 joypad ok, but I think my approach is a little bit hackish.
> The iPAQ h6300 joypad has 5 sensors that are located in following diagonal locations
> 
> 	UL - Up/Left
> 	DL - Down/Left
> 	DR - Down/Right
> 	UR - Up/Right
> 	CT - Center
> 
> If I press the key-pad for example to North, the joypad will generate 3 keydown events. (CT, UL and UR)
> Same logic applies to all 4 main directions both when the key is pressed down or released.
> Therefore I have put the driver to listen the real sensor events, but instead of sending them to userspace
> I will calculate a "virtual" key event (up, right, down or left) and send that to the userspace.
> 
> I am not yet proposing this patch to be applied to omap kernel, but would anyway like to hear
> some suggestions how to handle this kind of situation.

Maybe you could update it now against the current git tree?

Now that all the key mappings are done in board-*.c files it should be
easy to add support for h6300 too.

Tony
