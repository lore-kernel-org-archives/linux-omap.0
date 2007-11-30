From: David Brownell <david-b@pacbell.net>
Subject: Re: ALSA support for H2 board
Date: Fri, 30 Nov 2007 10:43:39 -0800
Message-ID: <200711301043.39503.david-b@pacbell.net>
References: <462684.16917.qm@web34311.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <462684.16917.qm@web34311.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 30 November 2007, Carlos Davila wrote:
> David,
>    
>   I understood from your previous message: "Better IMO to get
>   the tsc210x core working on tsc2101 chips" that there are
>   bugs in the tsc2101 drivers used by ALSA...which leaves me

No, it's just that the driver you referenced is using old
driver infrastructure.  That's not "bugs", it's just "this
code needs updating".

- Dave

>   no choice but to use OSS, since I know nothing about
>   debugging/writing device drivers.    
>    
>   Am I completely off the mark? Would appreciate any suggestions you may have.
>    
>   Best,
>   Carlos
> 
> David Brownell <david-b@pacbell.net> wrote:
>   On Friday 30 November 2007, Carlos Davila wrote:
> > OK understood, I'll use OSS then. 
> 
> You seem to have leaped from "use a more modern SPI framework"
> to "use old sound framework" ... how does that happen??
> 
> 
> > David Brownell wrote:
> > On Thursday 29 November 2007, comunerito wrote:
> > > CC [M] sound/arm/omap/omap-alsa-tsc2101.o
> > 
> > Better IMO to get the tsc210x core working on tsc2101 chips...
> > 
> > 
> > 
> 
> 
