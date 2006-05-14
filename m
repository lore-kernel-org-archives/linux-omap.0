From: Imre Deak <imre.deak@nokia.com>
Subject: Re: is dynamic tick working?
Date: Sun, 14 May 2006 20:57:12 +0300
Message-ID: <44676F78.1010004@nokia.com>
References: <200605121905.13405.david-b@pacbell.net>	<20060514104911.GB4715@atomide.com>
	<200605140919.09540.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605140919.09540.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext David Brownell wrote:
> On Sunday 14 May 2006 3:49 am, Tony Lindgren wrote:
>> * David Brownell <david-b@pacbell.net> [060512 19:05]:
>>> In short, enabling dyntick got me 14x as many IRQs, instead of
>>> shrinking the number of IRQs.  Known bug?
>> Is this with touchscreen enabled? I saw something similar last week
>> where SPI was generating interrupts continuously. I think Imre has a
>> patch for that already available.
> 
> It was, but I don't think I've seen such a patch yet.
> 
> I had noticed that the ads7846 code grew a glitch whereby its timer
> polls for position even when the "pen" isn't down.  

The problem is caused by the ads7846 generating interrupts during the 
measurement, which do not signal an actual pen down. Though the IRQ line 
is disabled it will still be latched and serviced at the end of the 
measurement when the IRQ line is reenabled. This will start another 
round of measurements..

To solve this we have to check the state of the IRQ line at the time of 
the interrupt if it's a "real one". The patch is already in the mainline 
tree, I've also sent it to Tony after I noticed it's missing from the 
OMAP tree. My fault, I should've kept the driver up-to-date in both trees..

--Imre

 > That's oddly similar to a glitch in omap-keyboard, where it keeps a
 > timer active even when no Mistral key is pressed.
> 
> 
>> In general dyntick should work, and you should see about 4-6HZ idle
>> tick rate.
> 
> Depending on drivers, it seems ... ;)
> 
> I have a patch to get rid of the OHCI root hub polling, which will
> get rid of one 4Hz timer.
> 
> - Dave
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
