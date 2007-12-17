From: Tony Lindgren <tony@atomide.com>
Subject: Re: RFC: 3430 USB support
Date: Sun, 16 Dec 2007 17:12:59 -0800
Message-ID: <20071217011258.GY7388@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804F64BA1@dbde01.ent.ti.com>
	<87ir3c52g2.fsf@vence.hilman.org>
	<5DF83221BE20114E9C331F665ACBC08075E7BB@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08075E7BB@dbde01.ent.ti.com>
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
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Pandita, Vikram <vikram.pandita@ti.com> [071205 22:56]:
> 
> Hi Kevin/Tony/David/3430-USB-interested-group
> 
> As far as USB on 3430 is concerned, following is the difference between 3430 ES1.0 and 3430ES2.0:
> 
> 3430 ES1.0:
> 	USB Core1: MUSB(old) + ISP1504 
> 	USB Core2: FS-OHCI + FS-OTG + FS-DEV (old - Legacy 2430 way)
> 
> 3430 ES 2.0:
> 	USB Core1	: MUSB(old)+ T2-Transceiver(NEW)
> 	USB Core2	: EHCI/OHCI block (NEW) <---------- All new replacing old block
> 
> USB Core1 MUSB: 
> We should be able to get MUSB working for both ES1.0 and ES2.0 as there is no extra programming required for the ULPI transceivers. Only the transceiver is changing from ISP1504 to T2.
> So Kevin we will look into the issue you reported of MUSB not working on ES1.0
> 
> USB Core2: 
> The tricky part is the USB Core2. It is completely replacing the Full-speed OHCI block on ES2.0
> What we are planning is that for 3430, we will support only the ES2.0 and not complicate things for the Core2. Is that fine? 
> 
> Also I am not sure how many people are using the ES1.0 version? 

Yes, sounds like ES1.0 will be gone soon and only used by few people
before they upgrade to ES2.0 also. So let's just keep the core parts
for ES1.0 working, and not worry about drivers beyond serial and
Ethernet.

Tony
