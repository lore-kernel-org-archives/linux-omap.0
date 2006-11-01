From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm fields
	missing
Date: Wed, 1 Nov 2006 13:48:33 -0800
Message-ID: <200611011348.34536.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0611011552330.8259-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.44L0.0611011552330.8259-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 November 2006 1:07 pm, Alan Stern wrote:

> I don't know what's going on with the OMAP tree, but it shouldn't be 
> possible to set CONFIG_USB_SUSPEND without also setting CONFIG_PM.

I'm suspecting the issue was just a broken defconfig, because that's
exactly what I see.  Specifically, omap_h2_1610_defconfig is borked.

Though why that broken defconfig didn't get fixed when the kernel
got built, I don't know ...

Sorry to bother you with that; I should have looked closer too, but
I thought one of the nyet-merged patches had those same symptoms.

- Dave
