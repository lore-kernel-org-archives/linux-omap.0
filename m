From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB HSET driver
Date: Wed, 23 May 2007 02:34:37 -0700
Message-ID: <200705230234.37346.david-b@pacbell.net>
References: <5DF83221BE20114E9C331F665ACBC0800305CC48@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC0800305CC48@dbde01.ent.ti.com>
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
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 23 May 2007, Pandita, Vikram wrote:
> Hi Tony 
> As per Greg's suggestion of introducing HSET driver in ope
> n source, can we push the HSET driver into MUSB for now till
> a complete implementation is made available in open source?   

Please, no.

This doesn't need to be musb-specific, and if it gets merged
it'll just create more pain to rip it out when musb_hdrc goes
upstream.

A much cleaner approach is to just do this in userspace with
usbfs ... issuing control requests to the hub ports.  That
will work with *ANY* high speed controller.

If the existing test mode support in the musb root hub is not
enough, just fix that bug.

- Dave
