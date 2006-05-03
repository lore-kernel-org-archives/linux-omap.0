From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2.6.17-rc3-omap] ads7846 updates, mostly for hwmon
Date: Wed, 3 May 2006 05:16:21 -0700
Message-ID: <20060503121620.GE30376@atomide.com>
References: <200605022221.26049.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605022221.26049.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [060502 22:22]:
> Here's a patch for the ads7846 driver ... mostly adds hwmon support, but
> it also handles the byte order correctly.  (That is, the fix should not
> have been in the OMAP tree's ads7846 code, but in omap_uwire instead.)
> 
> It goes no top of the omap_uwire patch, and also the OSK/Mistral update
> I sent a few days ago.

Thanks, I've pushed all your 5 patches.
 
> (I've sent a separate version of this patch upstream already, which doesn't
> need to revert those byteswap changes).

OK

Regards,

Tony
