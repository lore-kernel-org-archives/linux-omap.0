From: David Brownell <david-b@pacbell.net>
Subject: Re: Compact Flash Issue on OSK 5912
Date: Fri, 5 May 2006 13:22:42 -0700
Message-ID: <200605051322.42634.david-b@pacbell.net>
References: <31bab3780605050815v5906b07ap994bcb3204a8b49d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <31bab3780605050815v5906b07ap994bcb3204a8b49d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 05 May 2006 8:15 am, Bharat Kumar Reddy wrote:
>
> Has anyone faced these problems before and are there any patch fixes for this ?

Post any stack backtraces you get.  I saw similar rudeness on 2.6.17-current
but ISTR that 2.6.14-omap didn't have problems there.  It's not clear what
the problems are; my symptoms pointed more at IDE layer confusions with respect
to IRQ handling.

 
