From: David Brownell <david-b@pacbell.net>
Subject: Re: Pending October patches
Date: Fri, 3 Nov 2006 11:52:15 -0800
Message-ID: <200611031152.16397.david-b@pacbell.net>
References: <4548C32E.8010800@gmail.com> <20061101212850.GD6833@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061101212850.GD6833@atomide.com>
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

On Wednesday 01 November 2006 1:28 pm, tony@atomide.com wrote:

> > 27. [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm 
> > fields missing
> > http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008234.html
> 
> Sounds like this is getting fixed in the mainline tree.

No, the root cause of the problem is a borked h2 defconfig; but I'm
not clear how it got past the build step that's supposed to make sure
the current config matches all the Kconfig constraints.

(That is, USB_SUSPEND depends on PM, but only one of them was set in
the defconfig yet the build was proceeding ...)
