From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 15:46:00 -0700
Message-ID: <20100513224600.GB23014@suse.de>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005132311.26293.rjw@sisk.pl>
	<1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
	<201005132327.16163.rjw@sisk.pl>
	<1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
	<20100513214653.GA21120@suse.de>
	<13B9B4C6EF24D648824FF11BE896716203BB0EEAE9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BB0EEAE9@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 13, 2010 at 05:33:58PM -0500, Woodruff, Richard wrote:
> 
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Greg KH
> > Sent: Thursday, May 13, 2010 4:47 PM
> 
> > Also note that such a driver, without wakelocks, would never get tested,
> > and so, things start quickly diverging.
> 
> Do wakelock enabled drivers require a wakelock aware user space to
> function properly?

Not that I can tell, but others might know more.

> If the driver is added you want to make sure the benefit is there and
> testable for all userspaces.

Agreed.

thanks,

greg k-h
