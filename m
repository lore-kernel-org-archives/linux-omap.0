From: Matt Callow <mc-lists@tesco.net>
Subject: Re: FIQ Handler
Date: Fri, 07 Apr 2006 11:27:21 +0100
Message-ID: <44363E89.9050506@tesco.net>
References: <44343500.1030306@tesco.net> <20060405225656.GA19378@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060405225656.GA19378@atomide.com>
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

tony@atomide.com wrote:

>
>
>Search linux-arm-kernel@lists.arm.linux.org.uk list for it. Also look at
>the other FIQ handlers under arch/arm. It should not be hard to do.
>
>  
>
Thanks for the pointers. There is some useful info in there.  I was
expecting there to be something special about FIQ on the omap platform,
hence the message in the source, but it seems not.
I've solved my original data abort problem now, which was due to some
hardware not being mapped where I thought it was.

Matt
