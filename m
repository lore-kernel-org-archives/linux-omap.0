From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] MUSB: tracking down locking bugs
Date: Thu, 30 Aug 2007 22:48:31 -0700
Message-ID: <20070831054830.13B7B21D977@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070831025359.663866890@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070831025359.663866890@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, khilman@mvista.com
List-Id: linux-omap@vger.kernel.org

> With the help of the lock debugging features of the -rt patch, I'm
> trying to track down locking issues in the MUSB driver.

It was last done about 18 months ago, so it's clearly Time to
check those locks again.  :)
