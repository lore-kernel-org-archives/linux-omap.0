From: Kevin Hilman <khilman@mvista.com>
Subject: Re: new PRCM breakage: 2430 FB
Date: Wed, 13 Jun 2007 14:19:24 -0700
Message-ID: <46705F5C.8060902@mvista.com>
References: <46675138.80205@mvista.com>
	<Pine.LNX.4.64.0706131259150.26500@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0706131259150.26500@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Paul Walmsley wrote:
> On Wed, 6 Jun 2007, Kevin Hilman wrote:
> 
>> I just noticed that with the new PRCM reorg, the 2430 LCD is no longer
>> powering on.  I'll dig into it tomorrow, but any pointers would be
>> appreciated.
> 
> Hi Kevin,
> 
> I think I may have found the problem.  Could you give the attached patch
> a test?

Paul,

Thanks for digging.  It indeed helps.  The backlight comes on, but then
omapfb starts spitting out other errors:

omapfb omapfb: irq error status 00e2

omapfb omapfb: irq error status 0040

omapfb omapfb: irq error status 40e2

omapfb omapfb: irq error status 4040

omapfb omapfb: irq error status 4040

printk: 343155 messages suppressed.
omapfb omapfb: irq error status 4040

printk: 354528 messages suppressed.
[....]

I haven't dug any deeper on this yet.  I'll be on vacation next week,
then at OLS the week after, so unless anyone else does, I won't be able
to dig more until early July.

Kevin
