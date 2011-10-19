From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for	debug_prints
Date: Wed, 19 Oct 2011 12:21:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59303286934E1@dbde02.ent.ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36344 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1JSGve convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 02:51:34 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Govindraj,

On Wed, Oct 19, 2011 at 11:05:02, Mohammed, Afzal wrote:
> Hi Govindraj,
> 
> On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
> > If OMAP UART is used as console uart and debug is enabled,
> > avoid gating of uart clocks to print all debug prints.
> : 
> :
> >  			console_uart_id = uart->num;
> >  
> > +			if (cmdline_find_option("debug")) {
> > +				uart_debug = true;
> 
> Shouldn't "loglevel" also be checked?

Or use console_loglevel instead ?

Regards
Afzal
