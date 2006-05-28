From: Imre Deak <imre.deak@nokia.com>
Subject: Re: OMAP5912 touchscreen irq not working
Date: Sun, 28 May 2006 09:02:33 +0300
Message-ID: <44793CF9.2050101@nokia.com>
References: <4477F2BA.3080907@gmail.com>
	<200605270851.22051.david-b@pacbell.net>
	<1148760653.7041.19.camel@mammoth.research.nokia.com>
	<200605271514.53896.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605271514.53896.david-b@pacbell.net>
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
> On Saturday 27 May 2006 1:10 pm, Imre Deak wrote:
> 
>> I noticed that the ads7846 sampling rate is set too high in board-osk.c.
>> The spec allows a maximum bus frequency of 2.5MHz which gives a ~96k
>> sample rate. 
> 
> The spec says max sample rate of 125 KHz (at 5V) and describes Fclk
> in terms of Fsample (at an extremely fast 16 bit/sample rate) ...
> I saw no limit for Fclk, it's a function of the sample rate.

There is one table giving min/max timing values for Fclk as well and it
specifies 400ns  minimum clock period. We are using the 24 bit/sample
mode (8 for command, 16 for data) which at 120kHz/sample rate would need
 347ns clock period.

> 
> Regardless, the max sample frequency at 3V is not 96 KHz!  The
> graph shows 120 KHz... 96 KHz would be for about 2.1V.

I think, there should be a graph for each mode (15, 16, 24 bit/sample),
that one is valid for 16 bit/sample only.

> 
>> There is also the uwire clock patch in my previous post, 
>> which might have an effect on this issue.
> 
> Unlikely; it worked before, why would it stop working suddenly?
> Including with the previous SPI clock... it's some other change
> causing the breakage.

Yes, if it worked before with the wrong clock it's probably something else.

--Imre

> 
> - Dave
