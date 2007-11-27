From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC][PATCH] ARM: OMAP: Always enable the R/W access to all
 initiators in sram
Date: Tue, 27 Nov 2007 02:38:29 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711270232320.29188@utopia.booyaka.com>
References: <20071126020738.GA32424@party>
	<Pine.LNX.4.64.0711260348500.2694@utopia.booyaka.com>
	<9c9fda240711262235y22d45576n8469fa24790fc028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9c9fda240711262235y22d45576n8469fa24790fc028@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Kyungmin,

On Tue, 27 Nov 2007, Kyungmin Park wrote:

> There's no configuration ARCH_OMAP242X. :)

Yikes!  Nice catch :-)  

Time to start checking each patch for nonexistent config symbols before I 
send them.

> I'm not sure is it thre right to check cpu_is_omap242x()? or cpu_is_omap24xx()?

Probably Richard would be the right person to ask.  What do you think, 
Richard?

> After your patch commits, I will send the patch.

Okay, I will send in a patch for CONTROL_STATUS later today.


- Paul
