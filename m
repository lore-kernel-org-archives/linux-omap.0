From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm fields
	missing
Date: Wed, 1 Nov 2006 11:55:18 -0800
Message-ID: <200611011155.19966.david-b@pacbell.net>
References: <4547AB5C.4010801@nokia.com> <4548D4C1.9000405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4548D4C1.9000405@gmail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 November 2006 9:09 am, Dirk Behme wrote:

> do we have a mismatch here between usage of CONFIG_PM in 
> include/linux/usb.h and CONFIG_USB_SUSPEND in usb/core/usb.c 
> if CONFIG_PM isn't set for OMAP?

We have a case of patches not getting into the OMAP tree yet;
I'm not sure if they've been merged into kernel.org yet.

Alan, this tree is at ~RC3 ... is this fix in the main kernel
GIT tree yet, or just in MM?

- Dave
