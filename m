From: Carlos Davila <cdavila@att.net>
Subject: Re: ALSA support for H2 board
Date: Fri, 30 Nov 2007 09:18:34 -0800 (PST)
Message-ID: <462684.16917.qm@web34311.mail.mud.yahoo.com>
References: <200711300909.32925.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200711300909.32925.david-b@pacbell.net>
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

David,
   
  I understood from your previous message: "Better IMO to get the tsc210x core working on tsc2101 chips" that there are bugs in the tsc2101 drivers used by ALSA...which leaves me no choice but to use OSS, since I know nothing about debugging/writing device drivers.
   
  Am I completely off the mark? Would appreciate any suggestions you may have.
   
  Best,
  Carlos

David Brownell <david-b@pacbell.net> wrote:
  On Friday 30 November 2007, Carlos Davila wrote:
> OK understood, I'll use OSS then. 

You seem to have leaped from "use a more modern SPI framework"
to "use old sound framework" ... how does that happen??


> David Brownell wrote:
> On Thursday 29 November 2007, comunerito wrote:
> > CC [M] sound/arm/omap/omap-alsa-tsc2101.o
> 
> Better IMO to get the tsc210x core working on tsc2101 chips...
> 
> 
> 
