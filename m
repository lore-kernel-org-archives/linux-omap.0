From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-rc2-omap1] tsc210x cleanup
Date: Wed, 15 Aug 2007 03:54:44 -0700
Message-ID: <20070815105444.GI19754@atomide.com>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<200708102004.59747.david-b@pacbell.net>
	<20070813070512.GC13948@atomide.com>
	<200708132238.13676.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708132238.13676.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070813 23:11]:
> This is mostly cleanup of the tsc210x patch, but some bugs were fixed so now
> it works on tsc2101 too.  Also, a few issues are now noted in the code:
> 
>  Tool-reported:
>   - Address checkpatch.pl issues in the original patch
>   - And also "sparse" issues
> 
>  Previously wrong:
>   - Cope with CONFIG_SOUND_MODULE
>   - Register accessor routines will now return error codes
>   - ... many callers now abort cleanly after errors
>   - Don't depend on seeing only a rev #1 tsc2102 chip!
>   - Add missing EXPORT_SYMBOL declarations
> 
>  Style issues:
>   - BUG_ON() is strongly to be avoided
>   - So are macros that capture variables
>   - And needless casting from void pointers
>   - And type punning
>   - Use dev_*() for messaging where practical
>   - Use u16 not uint16_t, etc
>   - Various other whitespace issues
>   - Avoid __FUNCTION__
>   - Single-lines for file-top comments; no whole paths
> 
>  Object code size and Other cleanup:
>   - Compile most strings out unless -DDEBUG is configured (saving space)
>   - Move some code into exit sections (then it may well vanish, saving space)
>   - Add some header comments
> 
>  Open issues:
>   - Hwmon needs to know VREF and the chip type, and to scale its values
>   - Upstream push should exclude audio until some version is working
>   - Audio will needs to export symbols to modules, too
>   - Lots of the I/O calls (especially audio) still don't handle errors
>   - How could board init code get board-specific temp calibration data?
>  
> Also the Kconfig is more open-ended; tsc210x might in the future include the
> tsc2100 and tsc2111, it doesn't need to be limited to tsc2101 and tsc2102.

Pushing today.

Tony
