From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap-keypad: Added driver model
Date: Mon, 28 Nov 2005 18:56:07 -0800
Message-ID: <20051129025607.GH8319@atomide.com>
References: <20051126094710.90489.qmail@web32911.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051126094710.90489.qmail@web32911.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [051128 18:52]:
> Tony,
> 
> Attached patch adds the driver model support for omap-keypad.c. Moved
> muxing to plat-omap/devices.c.

Thanks pushing todya.
 
> Could you please test it on any of omap1 boards?

Seems to work, at least Innovator wakes up to a key :)

Tony
