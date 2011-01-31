From: Sutharsan <srmt@cypress.com>
Subject: Re: [PATCH] Staging: Westbridge: fix EXPORT_SYMBOL errors reported
 by checkpatch.pl
Date: Mon, 31 Jan 2011 14:09:38 -0800
Message-ID: <1296511778.1772.33.camel@sutharsan-laptop>
References: <1296061134.4116.7.camel@sutharsan-laptop>
	 <20110131214032.GB1629@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110131214032.GB1629@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-01-31 at 13:40 -0800, Greg KH wrote:
> On Wed, Jan 26, 2011 at 08:58:54AM -0800, Sutharsan wrote:
> > 
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
> Why was this sent again?
> totally confused,
I apologize for resending and creating confusion.
There has been a problem with the mail client.
Please ignore this as well.
> 
> greg k-h
> 



---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
