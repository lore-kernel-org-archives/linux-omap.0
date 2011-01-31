From: Sutharsan <srmt@cypress.com>
Subject: Re: Staging: Westbridge: fix EXPORT_SYMBOL errors reported by
 checkpatch.pl
Date: Mon, 31 Jan 2011 14:07:33 -0800
Message-ID: <1296511653.1772.30.camel@sutharsan-laptop>
References: <1296018202.3623.24.camel@sutharsan-laptop>
	 <20110131213140.GA1671@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110131213140.GA1671@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-01-31 at 13:31 -0800, Greg KH wrote:
> On Tue, Jan 25, 2011 at 09:03:22PM -0800, Sutharsan wrote:
> > From: Sutharsan Ramamoorthy <srmt@cypress.com>
> > 
> > This patch fixes errors reported by checkpatch.pl 
> > in westbridge device controller driver in the staging tree.
> > File containing EXPORT_SYMBOL() macros for all the APIs exported 
> > by the westbridge software has been removed. EXPORT_SYMBOL() 
> > macros are added after the corresponding function definitions.
> > 
> > Signed-off-by: Sutharsan Ramamoorthy <srmt@cypress.com>
> 
> I've already applied this patch, and you should have gotten the "this
> patch has been applied" email, right?
> 
> So why was it resent?
I resent adding '[PATCH]' tag which was missing in my first submission.
Please ignore this.
> 
> confused,
> 
> greg k-h
> 



---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
