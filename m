From: tony@atomide.com
Subject: Re: Cannot stall an endpoint 0 control transfer from a data stage
	cal lback function
Date: Fri, 11 May 2007 11:10:32 -0700
Message-ID: <20070511181031.GA28751@atomide.com>
References: <0474A5584072DA1197F50007E90E6B1141D45B@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <0474A5584072DA1197F50007E90E6B1141D45B@PORTIA>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Geoffrey Tam <geoffrey@evertz.com>
Cc: "'linux-omap-open-source@linux.omap.com'" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Geoffrey Tam <geoffrey@evertz.com> [070509 11:12]:
> Also sent to 'linux-usb-devel@lists.sourceforge.net'.
> 
> patch was created as per Documentation/SubmittingPatches.

Thanks, I tried it out quickly and looks like the last part of your
patch is already in the linux-omap git tree.

After applying the other parts, the mass storage gadget did not
enumerate though... I'll look into it again when I have a chance.

Do you have any chance to  try the current linux-omap git
tree and see how it works for you, then see what happens with
your patch?

Regards,

Tony
