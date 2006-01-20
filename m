From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] keypad: platform_data and 24xx support -exp
Date: Sat, 21 Jan 2006 01:27:05 +0200
Message-ID: <43D171C9.8020008@cc.jyu.fi>
References: <20051210130228.91620.qmail@web32905.mail.mud.yahoo.com>
	<20060114003728.GJ5499@atomide.com> <43C85C21.6030202@cc.jyu.fi>
	<20060120230257.GC6683@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060120230257.GC6683@atomide.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Yes, I will to pull the latest changes from git and try to make the merge soon. 
There is still couple of issues we want to resolve before starting to submit h6300 patches.

Mika

Tony Lindgren wrote:

>Hi Mika,
>
>* lamikr <lamikr@cc.jyu.fi> [060113 17:57]:
>  
>
>>Has anybody needed a joypad driver for the omap-boards? 
>>I have made changes to keypad driver so that it will support h6300 joypad ok, but I think my approach is a little bit hackish.
>>The iPAQ h6300 joypad has 5 sensors that are located in following diagonal locations
>>
>>	UL - Up/Left
>>	DL - Down/Left
>>	DR - Down/Right
>>	UR - Up/Right
>>	CT - Center
>>
>>If I press the key-pad for example to North, the joypad will generate 3 keydown events. (CT, UL and UR)
>>Same logic applies to all 4 main directions both when the key is pressed down or released.
>>Therefore I have put the driver to listen the real sensor events, but instead of sending them to userspace
>>I will calculate a "virtual" key event (up, right, down or left) and send that to the userspace.
>>
>>I am not yet proposing this patch to be applied to omap kernel, but would anyway like to hear
>>some suggestions how to handle this kind of situation.
>>    
>>
>
>Maybe you could update it now against the current git tree?
>
>Now that all the key mappings are done in board-*.c files it should be
>easy to add support for h6300 too.
>
>Tony
>
>  
>
