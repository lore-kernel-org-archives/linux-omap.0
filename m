From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 17:33:58 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BB0EEAE9@dlee02.ent.ti.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
 <201005132311.26293.rjw@sisk.pl>
 <1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
 <201005132327.16163.rjw@sisk.pl>
 <1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
 <20100513214653.GA21120@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100513214653.GA21120@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>, Daniel Walker <dwalker@fifo99.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Brian Swetland <swetland@google.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.w>
List-Id: linux-omap@vger.kernel.org


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Greg KH
> Sent: Thursday, May 13, 2010 4:47 PM

> Also note that such a driver, without wakelocks, would never get tested,
> and so, things start quickly diverging.

Do wakelock enabled drivers require a wakelock aware user space to function properly?  If the driver is added you want to make sure the benefit is there and testable for all userspaces.

Early Android service managers did take/release userspace locks to ensure the handoff worked.

Getting all these drivers is positive.  Getting to some constraint mechanism is positive.  It does need to exist end to end to make a difference at the battery.

Regards,
Richard W.
